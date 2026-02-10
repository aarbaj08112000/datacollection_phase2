"use client";

import {Container, Row, Col} from "react-awesome-styled-grid";
import {Tabs, TabsContent, TabsList, TabsTrigger} from "ui/components/Common/tabs"
import {Card,CardContent,
    CardFooter,
    CardHeader
} from "ui/components/Common/card"
import Image from "next/image";
import {formatNumber, dateFormat, displayNoDataCharacter,callAPI} from "lib/general"
import "ui/styles/car-detail-page.css";
import Lightbox from "yet-another-react-lightbox";
import "yet-another-react-lightbox/styles.css";
import "yet-another-react-lightbox/plugins/thumbnails.css";
import Thumbnails from "yet-another-react-lightbox/plugins/thumbnails";
import {useState} from "react";
import {LiaCheckCircle, LiaEdit} from "react-icons/lia";
import {LiaCarSolid} from "react-icons/lia";
import {LiaCalculatorSolid} from "react-icons/lia";
import noDataFoundIcon from "ui/assets/images/norecord_img.png";
import MediaComponent from "utils/MediaComponent"
import SidePopup from "ui/components/Common/side-popup";
import CarDocumentUpload from "ui/components/Car/CarDocumentUpload.jsx";
import { LuUpload } from "react-icons/lu";
export default function CarView({initialData, tagMasterData,documentTypesData}) {
    
    const carDetails = initialData;
    const tagNames = carDetails
        ?.tagNames
            ? carDetails
                .tagNames
                .split(",")
            : [];
    var exteriorImages = carDetails
        ?.exteriorImages
            ? carDetails
                .exteriorImages
                .map((url) => ({src: url.image_name}))
            : [];
    const interiorImages = carDetails
        ?.interiorImages
            ? carDetails
                .interiorImages
                .map((url) => ({src: url.image_name}))
            : [];
    exteriorImages = exteriorImages.concat(interiorImages);
    const imgCount = exteriorImages.length;
    const primary_img = carDetails
        ?.car_image
            ? [
                {
                    src: carDetails.car_image
                }
            ]
            : [];
    exteriorImages = exteriorImages.concat(primary_img);
    const [open, setOpen] = useState(false);
    const [sidePopup, setSidePopup] = useState(false);
    const [sidePopupConfig, setSidePopupConfig] = useState({
        "title": "Update Badges",
        "moduleTitle": "Badges",
        "moduleCode": "update_car_tag",
        "tags": tagMasterData,
        "selectedTag": carDetails
            ?.tag_information
                ? (carDetails.tag_information).map(tag => parseInt(tag.tag_id))
                : [],
        "carId": carDetails.carId
    });
    const toggleSidepopup = (mode) => {
        const sidePopupValue = sidePopup
            ? false
            : true;
        setSidePopup(sidePopupValue);
    };
    const [sideDocumentPopup, setSideDocumentPopup] = useState(false);
    const toggleSideDocumentpopup = (mode) => {
        const sidePopupValue = sideDocumentPopup
            ? false
            : true;
            setSideDocumentPopup(sidePopupValue);
    };

    
    const categorizedFeatures = (features) => {
        return features.reduce((acc, feature) => {
            const category = feature.featureCategoryName;

            if (!acc[category]) {
                acc[category] = [];
            }

            acc[category].push(feature);

            return acc;
        }, {});
    };
    const carFeatures = carDetails
        ?.features
            ? categorizedFeatures(carDetails.features)
            : [];

    const fetchData = async (carId = 0) => {
        try {
            const responseData = await callAPI(
                `/api/car/cars-detail?car_id=${carId}`,
                "GET",
                true
            );
            var carDetails = responseData?.data?.data?.car_details;
            setSidePopupConfig({
                "title": "Update Badges",
                "moduleTitle": "Badges",
                "moduleCode": "update_car_tag",
                "tags": tagMasterData,
                "selectedTag": carDetails
                    ?.tag_information
                        ? (carDetails.tag_information).map(tag => parseInt(tag.tag_id))
                        : [],
                "carId": carDetails.carId
        
            })
        } catch (error) {
            console.error("Failed to fetch user data:", error);
            // notFound();
        }
    }
    return (
        <div className="p-0">
            <Tabs defaultValue="account" className="w-full flex detail-block">
                {/* Sidebar for Tabs */}
                <TabsList
                    className="flex flex-col space-y-2  justify-start pt-4 bg-card ml-10 mt-3 p-4 w-1/6 h-[calc(100vh-206px)] overflow-auto hidden">
                    <ul className="p-0 pb-2 mb-2 border-b w-full">
                        <li
                            className="module-heading-title font-semibold text-lg flex flex-col mt-2 pb-3">
                            <span className="text-gray-800 leading-tight flex items-center gap-20">{carDetails['carName']}</span>
                            {/* <span className="text-sm text-gray-600">Work In Progress (Non Tradable)</span> */}
                        </li>
                    </ul>
                    <TabsTrigger
                        value="account"
                        className="w-full text-left px-4 py-2 rounded-md transition-colors
                     data-[state=active]:bg-[var(--primary)] data-[state=active]:text-white justify-start hover:text-[var(--primary)]">
                        Details
                    </TabsTrigger>
                    {/* <TabsTrigger value="password" className="w-full text-left px-4 py-2 rounded-lg transition-colors
                     data-[state=active]:bg-[var(--primary)] data-[state=active]:text-white justify-start hover:text-[var(--primary)]">Password</TabsTrigger> */
                    }
                </TabsList>

                {/* Tab Content */}
                <div className="flex-1 pr-0 pt-0 detail-block">
                    <TabsContent value="account">
                        <Container className="mb-4 max-w-full detail-container">
                            <Row>
                                <Col xs={1.2} md="auto" className="pr-0">
                                    <Card className="mb-5 mr-4">
                                        <CardHeader className="pt-3 pb-1 border-none !mb-0 !mt-0">
                                            <div className="p-0 pb-0 mb-1 flex flex-row font-montserrat">
                                                <div className="module-heading-title font-semibold text-lg  ml-0 w-3/4">
                                                    <span className="text-gray-800 leading-tight">{carDetails['carName']}</span>
                                                </div>
                                                <div
                                                    className="module-heading-title font-semibold text-lg  ml-0 w-1/4 justify-end flex mt-1">
                                                    <span
                                                        className={`px-4 py-0 text-base font-medium rounded-md status-label-box h-6   ${carDetails.status === "Active"
                                                            ? "bg-green-500"
                                                            : "bg-red-500"}  text-white `}>
                                                        {carDetails.status}
                                                    </span>
                                                </div>
                                            </div>
                                        </CardHeader>
                                        <CardHeader className="p-0 pt-2 pb-1 !mt-1 !mb-0 border-b-0">
                                            <CardContent
                                                className="flex  items-center justify-center p-2 border border-[#f1f0f0] rounded relative">
                                                <Image
                                                    src={carDetails.car_image}
                                                    alt="Full-size image"
                                                    width={600}
                                                    height={400}
                                                    className="max-w-full max-h-full"/> {
                                                    imgCount > 0 && (
                                                        <> < button type = "button" onClick = {
                                                            () => setOpen(true)
                                                        } > <div className="more-images">
                                                            +{imgCount}
                                                            Photos
                                                        </div>
                                                    </button>
                                                    <Lightbox
                                                        plugins={[Thumbnails]}
                                                        open={open}
                                                        close={() => setOpen(false)}
                                                        slides={exteriorImages}/>
                                                </>
                                                    )
                                                }

                                            </CardContent>
                                            <div className="flex justify-center">
                                                <div className="module-heading-title font-semibold text-xl  mt-2">
                                                    <span className="text-gray-800 leading-tight">{carDetails['carName']}</span>
                                                    {/* <span className="text-gray-800 leading-tight">{carDetails['carName']}</span> */}
                                                </div>
                                            </div>
                                        </CardHeader>
                                        <CardHeader className="border-none !p-0 !my-2">
                                            <div className="p-0 pb-0 mb-1 flex flex-row  bg-gray-100 rounded-sm">
                                                <div
                                                    className="module-heading-title font-semibold text-sm  ml-0 w-2/4 justify-center flex p-2">
                                                    <span className="text-gray-800 leading-tight flex items-center"><LiaCarSolid className="w-5 h-5 mr-2"/>AED {formatNumber(carDetails['price'])}</span>
                                                </div>
                                                <div
                                                    className="module-heading-title font-semibold text-sm  ml-0 w-2/4 justify-center flex p-2">
                                                    <span className="text-gray-800 leading-tight flex items-center"><LiaCalculatorSolid className="w-5 h-5 mr-2"/>EMI: AED {formatNumber(carDetails['monthlyEMIAmount'])}</span>
                                                </div>
                                            </div>
                                        </CardHeader>
                                        <CardContent className="pb-0 border border-[#f1f0f0] mx-6 rounded p-3 mb-3">
                                            <div className="flex flex-row  text-sm mb-2">
                                                <p className="basis-2/4 text-[#7E7E7E]">Slug</p>
                                                <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['car_slug'])}</p>
                                            </div>
                                            <div className="flex flex-row  text-sm mb-2">
                                                <p className="basis-2/4 text-[#7E7E7E]">Mfg</p>
                                                <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['manufactureYear'])}</p>
                                            </div>
                                            <div className="flex flex-row  text-sm mb-2">
                                                <p className="basis-2/4 text-[#7E7E7E]">Reg No</p>
                                                <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['registrationNumber'])}</p>
                                            </div>
                                        </CardContent>

                                    </Card>

                                    <Card className="mb-5 mr-4">
                                        <CardHeader className="pt-3 pb-1 border-none !mb-0 !mt-3">
                                            <div className="p-0 pb-0 mb-1 flex flex-row ">
                                                <div className="module-heading-title font-medium text-lg flex w-full">
                                                    <div className="w-3/4">
                                                        <h2 className=" text-[#555555]">Badges Details</h2>
                                                    </div>
                                                    <div className="w-1/4">
                                                        <LiaEdit
                                                            className="float-end text-[var(--primary)] text-xl cursor-pointer"
                                                            onClick={() => toggleSidepopup("add")}/>
                                                    </div>

                                                </div>
                                            </div>
                                        </CardHeader>
                                        <SidePopup
                                            isOpen={sidePopup}
                                            isClose={toggleSidepopup}
                                            configration={sidePopupConfig}
                                            id={initialData.carId}
                                            fetchData={fetchData}/>

                                        <CardContent className="pb-0">
                                            <div className="flex items-center justify-start gap-3 flex-wrap">

                                                    {
                                                        tagNames != ""
                                                            ? tagNames.map((tag_value, index) => (
                                                                <div
                                                                    key={index}
                                                                    className="border p-2 shadow rounded-sm text-center w-auto min-w-max  text-[var(--primary)]">
                                                                    {tag_value}
                                                                </div>
                                                            ))
                                                            : (
                                                                <> < MediaComponent imageObj = {
                                                                    noDataFoundIcon
                                                                }
                                                                className = "mx-auto my-0 w-1/5 " svgImg = "false" > </MediaComponent>
                                                            <p className="text-gray-500 text-lg font-semibold w-full mx-auto text-center">No badges found !</p>
                                                        </>
                                                            )

                                                    }
                                            </div>

                                        </CardContent>
                                        <CardFooter>
                                            {/* <Button>Save changes</Button> */}
                                        </CardFooter>
                                    </Card>

                                    <Card className="h-[224px] mr-4 ">
                                        <CardHeader className="pt-3 pb-1 border-none !mb-0 !mt-3">
                                            <div className="p-0 pb-0 mb-1 flex flex-row ">
                                                <div className="module-heading-title font-medium text-lg ">
                                                    <h2 className=" text-[#555555]">EMI Detail</h2>
                                                </div>
                                            </div>
                                        </CardHeader>

                                        <CardContent className="pb-0">
                                            <div className="flex flex-row  text-sm mb-2">
                                                <p className="basis-2/4 text-[#7E7E7E]">Negotiable</p>
                                                <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['negotiable'])}</p>
                                            </div>
                                            <div className="flex flex-row  text-sm mb-2">
                                                <p className="basis-2/4 text-[#7E7E7E]">Negotiable Range</p>
                                                <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['negotiableRange'])}</p>
                                            </div>
                                            <div className="flex flex-row  text-sm mb-2">
                                                <p className="basis-2/4 text-[#7E7E7E]">Monthly EMI</p>
                                                <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['monthlyEMIAmount'])}</p>
                                            </div>

                                        </CardContent>
                                        <CardFooter>
                                            {/* <Button>Save changes</Button> */}
                                        </CardFooter>
                                    </Card>

                                </Col>
                                <Col xs={2.76} md="auto" className="mb-5 !p-0 ">
                                    <div className="flex flex-row">
                                        <Card className="w-9/12 mr-3">
                                            <CardHeader className="pt-3 pb-1 border-none !mb-0 !mt-3">
                                                <div className="p-0 pb-0 mb-1 flex flex-row ">
                                                    <div className="module-heading-title font-medium text-lg ">
                                                        <h2 className=" text-[#555555]">Specification</h2>
                                                    </div>
                                                </div>
                                            </CardHeader>
                                            <CardContent className="pb-0">
                                                <div className="flex flex-row  text-sm mb-2">
                                                    <div className="basis-2/4 ">
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">VIN Number</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['vinNumber'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Chassis Number</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['chassisNumber'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Manufacture Year</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['manufactureYear'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Model</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['modelName'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">KM Driven/Mileage</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['drivenDistance'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Body Type</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['negotiable'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Exterior Color</p>
                                                            <p className="basis-2/4 ">
                                                                <spna className="float-left min-w-14">{displayNoDataCharacter(carDetails['exteriorColor'])}</spna>
                                                                <span
                                                                    className={`h-[22px] w-[22px] float-left rounded-[6px]  ml-[6px] mt-[1px] border border-gray-300 `}
                                                                    style={{
                                                                        backgroundColor: carDetails['exteriorColor']
                                                                    }}></span>
                                                            </p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Interior Color</p>
                                                            <p className="basis-2/4 ">
                                                                <spna className="float-left min-w-14">{displayNoDataCharacter(carDetails['interiorColor'])}</spna>
                                                                <span
                                                                    className={`h-[22px] w-[22px] float-left rounded-[6px]  ml-[6px] mt-[1px] border border-gray-300`}
                                                                    style={{
                                                                        backgroundColor: carDetails['interiorColor']
                                                                    }}></span>
                                                            </p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Fuel Type</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['fuelType'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Transmission Type</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['status'])}</p>
                                                        </div>
                                                    </div>
                                                    <div className="basis-2/4 ">
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Engine Capacity</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['engineCapacity'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Engine Type</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['engineType'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Engine Size</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['engineSize'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Horse Power</p>
                                                            <p className="basis-2/4 ">{formatNumber(carDetails['horsePower'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Steering Side</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['steeringSide'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Service History</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['serviceHistory'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Warranty</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['warranty'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">Seating Capacity</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['seatingCapacity'])}</p>
                                                        </div>
                                                        <div className="flex flex-row  text-sm mb-2">
                                                            <p className="basis-2/4 text-[#7E7E7E]">No. of Doors</p>
                                                            <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['numberOfDoors'])}</p>
                                                        </div>

                                                    </div>
                                                </div>

                                            </CardContent>
                                            <CardFooter>
                                                {/* <Button>Save changes</Button> */}
                                            </CardFooter>
                                        </Card>
                                        <Card className="w-1/4">
                                            <CardHeader className="pt-3 pb-1 border-none !mb-0 !mt-3">
                                                <div className="p-0 pb-0 mb-1 flex flex-row ">
                                                    <div className="module-heading-title font-medium text-lg ">
                                                        <h2 className=" text-[#555555]">Activities</h2>
                                                    </div>
                                                </div>
                                            </CardHeader>
                                            <CardContent className="pb-0">
                                                <div className="flex flex-row  text-sm mb-2 h-72">
                                                    <div className="flex-grow flex flex-col items-center justify-center">
                                                        {/* <Image src={NoDataImage} alt="No records found" width={100} height={100} /> */}
                                                        <MediaComponent
                                                            imageObj={noDataFoundIcon}
                                                            className="mx-auto my-5"
                                                            svgImg="false"></MediaComponent>
                                                        <p className="text-gray-500 text-lg font-semibold">No activities found!</p>
                                                    </div>
                                                </div>
                                            </CardContent>
                                            <CardFooter>
                                                {/* <Button>Save changes</Button> */}
                                            </CardFooter>
                                        </Card>
                                    </div>

                                    <Card className="mt-5">
                                        <CardHeader className="pt-3 pb-1 border-none !mb-0 !mt-3">
                                            <div className="p-0 pb-0 mb-1 flex flex-row ">
                                                <div className="module-heading-title font-medium text-lg ">
                                                    <h2 className=" text-[#555555]">Features</h2>
                                                </div>
                                            </div>
                                        </CardHeader>
                                        <CardContent className="pb-0">
                                            <div className="grid grid-cols-2  text-sm mb-2">
                                                {
                                                    
                                                    Object
                                                        .entries(carFeatures || {})
                                                        .map(([category, features]) => (
                                                            <div className="basis-2/4 text-gray-600 before-border relative">
                                                                {category}
                                                                <div key={category} className="mb-4">
                                                                    {/* Category Title */}
                                                                    <div className="flex flex-row  text-sm mb-2">
                                                                        <p className="basis-2/4">
                                                                            <b className="float-left font-semibold">{category}</b>
                                                                        </p>
                                                                    </div>
                                                                    {/* Feature List */}
                                                                    <div className="grid grid-cols-2    text-sm mb-2">
                                                                        {
                                                                            features.map((feature, index) => (
                                                                                <p className="basis-2/4">
                                                                                    <LiaCheckCircle className="text-green-500 float-left mr-2 mt-[2px]"/>
                                                                                    <b className="float-left font-normal">{feature.featureName}</b>
                                                                                </p>
                                                                            ))
                                                                        }
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        ))
                                                }

                                            </div>

                                        </CardContent>
                                    </Card>
                                    <Card className="mt-5">
                                        <CardHeader className="pt-3 pb-1 border-none !mb-0 !mt-3">
                                            <div className="p-0 pb-0 mb-1 flex flex-row ">
                                                <div className="module-heading-title font-medium text-lg flex w-full">
                                                    <div className="w-3/4">
                                                        <h2 className=" text-[#555555]">Documents</h2>
                                                    </div>
                                                    <div className="w-1/4">
                                                        <LuUpload
                                                            className="float-end text-[var(--primary)] text-xl cursor-pointer"
                                                            onClick={() => toggleSideDocumentpopup("add")}/>
                                                    </div>
                                                    
                                                        <CarDocumentUpload 
                                                         isOpen={sideDocumentPopup}
                                                         isClose={toggleSideDocumentpopup}
                                                         documentTypesData={documentTypesData} 
                                                         carId={carDetails.carId}/>
                                                    

                                                </div>
                                            </div>
                                        </CardHeader>
                                        <CardContent className="pb-0">
                                            <div className="grid grid-cols-2  text-sm mb-2">
                                                {
                                                    
                                                    Object
                                                        .entries(carFeatures || {})
                                                        .map(([category, features]) => (
                                                            <div className="basis-2/4 text-gray-600 before-border relative">
                                                                {category}
                                                                <div key={category} className="mb-4">
                                                                    {/* Category Title */}
                                                                    <div className="flex flex-row  text-sm mb-2">
                                                                        <p className="basis-2/4">
                                                                            <b className="float-left font-semibold">{category}</b>
                                                                        </p>
                                                                    </div>
                                                                    {/* Feature List */}
                                                                    <div className="grid grid-cols-2    text-sm mb-2">
                                                                        {
                                                                            features.map((feature, index) => (
                                                                                <p className="basis-2/4">
                                                                                    <LiaCheckCircle className="text-green-500 float-left mr-2 mt-[2px]"/>
                                                                                    <b className="float-left font-normal">{feature.featureName}</b>
                                                                                </p>
                                                                            ))
                                                                        }
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        ))
                                                }

                                            </div>

                                        </CardContent>
                                    </Card>
                                    <div className="flex flex-row mt-5">

                                        <Card className="w-2/4 mr-3">
                                            <CardHeader className="pt-3 pb-1 border-none !mb-0 !mt-3">
                                                <div className="p-0 pb-0 mb-1 flex flex-row ">
                                                    <div className="module-heading-title font-medium text-lg ">
                                                        <h2 className=" text-[#555555]">Registration Details</h2>
                                                    </div>
                                                </div>
                                            </CardHeader>
                                            <CardContent className="pb-0">
                                                <div className="flex flex-row  text-sm mb-2">
                                                    <p className="basis-2/4 text-[#7E7E7E]">Registration Number</p>
                                                    <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['registrationNumber'])}</p>
                                                </div>
                                                <div className="flex flex-row  text-sm mb-2">
                                                    <p className="basis-2/4 text-[#7E7E7E]">Registration Date</p>
                                                    <p className="basis-2/4 ">{dateFormat(carDetails['registrationDate'])}</p>
                                                </div>
                                                <div className="flex flex-row  text-sm mb-2">
                                                    <p className="basis-2/4 text-[#7E7E7E]">Registration Expiry</p>
                                                    <p className="basis-2/4 ">{dateFormat(carDetails['registrationExpiry'])}</p>
                                                </div>
                                                <div className="flex flex-row  text-sm mb-2">
                                                    <p className="basis-2/4 text-[#7E7E7E]">Insurance Type</p>
                                                    <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['insuranceType'])}</p>
                                                </div>
                                                <div className="flex flex-row  text-sm mb-2">
                                                    <p className="basis-2/4 text-[#7E7E7E]">Insurance Policy Number</p>
                                                    <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['insurancePolicyNumber'])}</p>
                                                </div>
                                                <div className="flex flex-row  text-sm mb-2">
                                                    <p className="basis-2/4 text-[#7E7E7E]">Insurance Expiry</p>
                                                    <p className="basis-2/4 ">{dateFormat(carDetails['insuranceExpiry'])}</p>
                                                </div>
                                            </CardContent>
                                            <CardFooter>
                                                {/* <Button>Save changes</Button> */}
                                            </CardFooter>
                                        </Card>
                                        <Card className="w-2/4 ">
                                            <CardHeader className="pt-3 pb-1 border-none !mb-0 !mt-3">
                                                <div className="p-0 pb-0 mb-1 flex flex-row ">
                                                    <div className="module-heading-title font-medium text-lg ">
                                                        <h2 className=" text-[#555555]">Location</h2>
                                                    </div>
                                                </div>
                                            </CardHeader>
                                            <CardContent className="pb-0">
                                                <div className="flex flex-row  text-sm mb-2">
                                                    <p className="basis-2/4 text-[#7E7E7E]">Location Name</p>
                                                    <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['locationName'])}</p>
                                                </div>
                                                <div className="flex flex-row  text-sm mb-2">
                                                    <p className="basis-2/4 text-[#7E7E7E]">ZIP Code</p>
                                                    <p className="basis-2/4 ">{displayNoDataCharacter(carDetails['zipCode'])}</p>
                                                </div>

                                            </CardContent>

                                            <CardFooter>
                                                {/* <Button>Save changes</Button> */}
                                            </CardFooter>
                                        </Card>
                                    </div>
                                    <Card className="w-full mr-4 mt-5">
                                        <CardHeader className="pt-3 pb-1 border-none !mb-0 !mt-3">
                                            <div className="p-0 pb-0 mb-1 flex flex-row ">
                                                <div className="module-heading-title font-medium text-lg ">
                                                    <h2 className=" text-[#555555]">Description</h2>
                                                </div>
                                            </div>
                                        </CardHeader>
                                        <CardContent
                                            className="pb-0"
                                            dangerouslySetInnerHTML={{
                                                __html: carDetails['carDescription']
                                            }}></CardContent>
                                        <CardFooter>
                                            {/* <Button>Save changes</Button> */}
                                        </CardFooter>
                                    </Card>
                                </Col>

                            </Row>
                        </Container>

                    </TabsContent>

                </div>
            </Tabs>
        </div>
    );

};
