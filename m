Return-Path: <linux-api+bounces-6259-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D1NEgy0+GmWzAIAu9opvQ
	(envelope-from <linux-api+bounces-6259-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 04 May 2026 16:58:20 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8941D4C045F
	for <lists+linux-api@lfdr.de>; Mon, 04 May 2026 16:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F230E3048567
	for <lists+linux-api@lfdr.de>; Mon,  4 May 2026 14:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631A3E0237;
	Mon,  4 May 2026 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="hBRMN5ZI";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="epSxO23Y"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8033DFC75;
	Mon,  4 May 2026 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906574; cv=fail; b=IM9/Nhm3jjsE98pZBX+HsZ+5EYiSy6HRz6dWjPhveObfBtHCK5RMK18XjUCb+QwDvT863jJxfCWS56UmK7iL1I7kPkTOJCJc3ydrgPPr63hfITKDvEShJf7rQhy+fZ2dl5OPhBkw9PTQb750GR/AgMaN5YQftfzKQ78dY4C5MIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906574; c=relaxed/simple;
	bh=6PkrMP/ADUuoEyOHA5vSJsVBqfvVrFpw+1ahrlCmIvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B0sT1a6isQqZwCLfP59D8IsyTnawc8sxQaOnqS9d1DNaxhtkXk5b5aBF4mnQYm0zoQWouVSEIah8rDqvDnTpd4BsZjjX6W4NAByYKm+WXwkrR0GTOfzQEC9+APTwioKIrzbuZGwXT1rqgAjD3VJJFbbj1nAYRFdQUn0eszP/964=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=hBRMN5ZI; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=epSxO23Y; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644AW9MW4122814;
	Mon, 4 May 2026 07:39:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=6PkrMP/ADUuoEyOHA5vSJsVBqfvVrFpw+1ahrlCmI
	vA=; b=hBRMN5ZItGWQUOwqVb/GKgB1H38gaiqYvVmag/QR6s/cVSQHEKVOm4pW2
	FygkEtPm3t+3497u1W+9v7QqCkCAM3bpbEXLfT+/mLtwPBf+cvXj2CIvmnp1sjbO
	tOYntYWVtqMn4VYFiK8MZpI78JnCnFF0GWtLuGlHukoN9hR8qGe6+awPwJ0dnobZ
	tuRrWPPLQiU7EWCp7kTGbL9LpwKExmAyizuwgS4wqD4ZwI0BpElX/aZ3pQAXEoNb
	rwgaK135ocz0Ku7UxU7gMlnWoNROGKv9TmkM/Oqfkzl2Q29/pSS1+dANHC3k+d5F
	7TMnjKz1QoGXCgEwEjs/1Y8NRTVsQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021120.outbound.protection.outlook.com [52.101.52.120])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4dwgtukee7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 07:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tumx/4II7x/CaBAWEfLgTrwm/ZDHU9LbOCPrVedJN0H/X++nS2EJElyb/zlol3cY0BvK+1uUWxSfFLj4ES9heV9oYCmEyr+08M61kEAIwKihF2Weha5FDHjI/GLH9ng6Zhi9RrnccnyxGs2qoLDvt7s1JH/QQmvqc4TmBuEnaCrrFDhtcLCbG7m4PaaduDf+aXfks9mFHbAENjBSXEZFe6cmVEXT4CgSXd6pi61FvYJz6Fw9H4RGpkxPcg9IGEDHJZnw9txyOTAKw9MLZHKKYNQnEeF9FX8eIxGBptK5JD/egBXIYYL/FwA58C7EQHaBjVtHQ93oNZygEFfD1c5bhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PkrMP/ADUuoEyOHA5vSJsVBqfvVrFpw+1ahrlCmIvA=;
 b=C4URUP41YPE+SJOf0Zl+60Z7kwLMgTHSi37ZZAsfMCwLe8HrqozfSxVatSTEQ+eNfUCrDsxFOPwOXE+9fSJWXgjLMcbTSWA/h2wxyhrw8CFheYge+ACMGdkwiurrvnKh+ak+UtGpI4hlnrrToE16nsN4uJm8zRCpFhkfQ71+P0NeeiN2TnuJ9k6FbWCoc8VN8aSVoEOKg6yqQPwNtawet9N2qtR+1+1SccetZjiw8Ow9haiILIEAI++pa8J8OzTxFw/tCtB0jRI5vyHU+i/UCwiFTXebscJEX82f70Eqg+b8KxDeYaysZUY1054jkgo84Qh+c9/BC3octix8fTRbpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PkrMP/ADUuoEyOHA5vSJsVBqfvVrFpw+1ahrlCmIvA=;
 b=epSxO23YSIdiCQYvcvHuXWUpxIzHCaxPadqWfWX5FP2Zhg7Fc5x4iFMTmhAAMbcDHPXES7gQgk+bf4f2uLJ0sQS2+/ax+1A7fpILUfsKZvT+ncQefMNg47Zn0tAxV8Mk95Jj27B3kqdehjYXkOswWWn+UNiwotJqy2RReV4kN/whFD48NhNOwTGG7ohg5BGIIgHjyqCj0L4Pp8F8ubgWr+KsUoBAeQnxI4HXgYRXk/AcSGAxekVlES5Q6QZBXqNlfnVo2cX+50XDdEF3JPgzI2QEu5a7uBj+6jH0piM/YL8dJYLpusIBuHcEE+4iIU83/oduSLLe29OywmJ4WFbLKA==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SA1PR02MB8672.namprd02.prod.outlook.com
 (2603:10b6:806:1ff::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 14:39:12 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 14:39:12 +0000
From: Jon Kohler <jon@nutanix.com>
To: Eric Biggers <ebiggers@kernel.org>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Herbert Xu
	<herbert@gondor.apana.org.au>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
Thread-Topic: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
Thread-Index: AQHc29PGEbbnBkALYk6dcQ18VVjQcQ==
Date: Mon, 4 May 2026 14:39:12 +0000
Message-ID: <4D424F50-7E9F-4B1F-AE9C-86D8526284E6@nutanix.com>
References: <20260430011544.31823-1-ebiggers@kernel.org>
In-Reply-To: <20260430011544.31823-1-ebiggers@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.500.181)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|SA1PR02MB8672:EE_
x-ms-office365-filtering-correlation-id: 50d03dce-30fa-4667-70fd-08dea9eae8db
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 Fsh7SGNeJA+Nia0qS59DrRGVypdWpgCIlctOZN2CXcyV/qbUILEk9gTMacJbaZAwDMGe4DNCsJRvt/9+CoYssoktxoppW7NlkhudCqRJI8UtUKPZEr6nczcy9l8GmmSjsa1iUKDGMIdfajw1X0rdG+BCxw4k4kvGbZmsfvdcRNIMNtF83mATnKxgzf0dKlrSsPE5QmtQXfHnauELcyFLa6sZ/krCCXMl3a0T9E2J7gI5Ejt2Tstzeqqo0/0xmbwhJmUcsnNCM2U93a0eL5xBGMmWyS0Q+n5+e4KytfuHz2C3evlMyUnXKNvU2NXJsGIEs1brTAzbmJhM2BMxUVAvAWNjlV6k/JYqf5ue8feP501+nVAR5ab8VxG90v1XZqg36m/H0gQrhwLJ8ECF8nuVUN7t1Svj7YoDENo7GB/FPXCzOWjMRCiK6uzThJBg2lJ+YT5Tt1dpXQzzqYdcySZIM9ivjPKfj3XLEGA9EokbVNzD8H/1FyiPyJcMC19PnjTLIKuz+fmbJelH5D8qwySQmGXB+lj2W54eDLdEoRooJpe9SnCtll7Os8oOLSqoTe/S+HW5o++3mW3QgL9+Cdk+kAJ432UjVmsvRqBJNSoDfJoQOSG8JH3Nl+TGG8F/3q4v9ZW/RGZ67mxIqZHgihiKTe9fmTvV+LtFX7/Kq/RElUZnc4VITyBbmjdgHXXHW+Yf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnkwenNhUlViZ2tIenoycFRrME5qMUgvRExpcXBzK0U4cjhRR1k4M2VxZmhD?=
 =?utf-8?B?ZUx3QXEwMGhGRmRjQWcvNVhXcmZkcmtiankzM2RXZk9BcHZuaUZRYnlBdGln?=
 =?utf-8?B?Nk1aYzE5b0h1b1M4UnB1M20wN2V3eFkxaS9KU0RabDlENEtrSDl5WEZRMHMw?=
 =?utf-8?B?UGFWbFhuS1E2bmhuckdzT0t2enpNaGp3UG9JdUZ1RTlwUE5yOElZSkRjeldL?=
 =?utf-8?B?RFUweGlHWnVuK3E4ajFQWGExalRScnVveER5bVl4TE8vaDRtUVk4TGliMWdR?=
 =?utf-8?B?VEJGa3c0UU5aNUVmV2JaZVJoQ1RYbkUydGJRMzZoYVF6NnkzMG00ZHprbUIx?=
 =?utf-8?B?MngzVGl3UXhhY0JuM3NUUzlxL0RzL0ZITFE0Q1FRR3BYZnduTDZYZ3luM0ls?=
 =?utf-8?B?RjFuak9yWmJoRXQ0Wnltak12ZHVrbUprc1RVVmpqL3E0dFdheWxrT05WZFFn?=
 =?utf-8?B?VFZmL2d0S0QxZzFOcmFjdkRHYTlzNVI1amlQbVFZc2ZNRkVTU21aQklWeGhS?=
 =?utf-8?B?SDdjc2t6a0J4dVZYNERHY29XdHRhTHVaL3NBcS9LV0liMy80NGFsQ2hEZlVj?=
 =?utf-8?B?am1LdmFiYWEwQ3Vaa083clljNWNENTVKY200SjJXc29GSWRBTWpIdWhsVXJt?=
 =?utf-8?B?dzQzWTBwN1NybXNYb25sOExWTnNtZ2VjckpCRjFnL1NKdjU5eXVYdm9lUTNh?=
 =?utf-8?B?RjdqcDlnT3Y5TVpwUUI4R1dWRXN3T3ZrMm5NQW9xa2liTStEdWg4UXpBTURN?=
 =?utf-8?B?RWdldUdobERITHF6UEhIOHVJZnoxeXpBRzB4N1d5WUNreldXVGJlNEJ2TUs0?=
 =?utf-8?B?VGFCa1Jqby90NEJKVzBrcnVGSzJMRU5GbVYxZVV3RmxGZUd5d3BaZW5IeDJ4?=
 =?utf-8?B?anF0V1V3QmhMSzFzR2MxWVVnaXpFV2w4V2FGMSt6c3krcW9ZWmhMcDNoRUVK?=
 =?utf-8?B?aEh6TzYzUFdkV0FHVmNvdzBwdVhUbTIweG13OEo1K3labDc5TklIeUt6Yng4?=
 =?utf-8?B?eTRUTkNkdzVTZzJIa01qUmJiVXE3dDlhTzNDR0ZaaloxSFZpeHlwS1JPUTZu?=
 =?utf-8?B?T0xuc1JqbWVJeE9jRDRObkNBNGYyclJKN2hQV1Nwb21oelp4cWdhUHRCMTls?=
 =?utf-8?B?SlhGSC9EVWpwaGovVVlEU2tJMHhrS0o1Y2tldSt3djVtbzFNM3pmcHV6SnU2?=
 =?utf-8?B?Y09ub2tMTFViQnRNbWJlcnZvSlFKVzI2eVNkU1UxR2F0bTYxSVpITUFJQlpl?=
 =?utf-8?B?U0treDFta3NpNjZOckdmSkE2RDk4dXUrNkxUbVRWRkFET1NJOHVMSzdJSnpw?=
 =?utf-8?B?M1pXYmxXYldyaTdpeWRydFRYdUhFd0lDNzNsVXVudUY4MnhVYTVQVVNESE45?=
 =?utf-8?B?V1hDUU1wbm1SQ2cydWxYYmI4bU1yV1BYTkdUcUZBbXNQbCtqWklhSEQyQTJm?=
 =?utf-8?B?bHhuSHpIRmxsV0ZzcEdFRW85b2xXVkRuZHlFYjdrd0daZXMxVXRzcVMvOGlH?=
 =?utf-8?B?NDhvdGVwdEQzNytoZit3MmxBZk9KZEJKUUJsaG1DcFJ3aGt3U0MrK0I1UDFH?=
 =?utf-8?B?STNoV0p5M3JidUJTaHJtbnNPc2FHQmdncXArQkE4OC9DTitMTGJwd3N2S0xG?=
 =?utf-8?B?YXJYd2Vxc3hyN01qRmR6MWFySkN5dHJiRmtZTGVITFNxTkltaUZLNzRRZEVT?=
 =?utf-8?B?VHdVVHpISVNMWGlzTEx6R2dpbkh0T21OMjlVaWxLbUVKUkE1c21HL1YvMzZO?=
 =?utf-8?B?WktqUDRyRTBVTVp0anh3THpNaFc3eEdFMkJxZXlnakdnSVJkVVM5eXRVa2lx?=
 =?utf-8?B?YklEa2h3SXYyV2gxQzRCeW9wL3dKQlc4NGNVYldQTFdsdGhjb3BoMlZrVml0?=
 =?utf-8?B?YWhLMVhpSXZoT1V6UUsxaGlnUmZVUnhDdjU4YlgzMExCUHIxNUt4MlRtaUg0?=
 =?utf-8?B?ejlkU1E1OUVJc2o2L3NvUjVQKzFEblpHRVByUzZtSCtUb2NHa3JtMEtmY3VF?=
 =?utf-8?B?bkVnWVpjUHhPVkNRVlFaSzM3UjFBOGZ6VkpnNmNBSnVpdW1NT2F1eFZTNXlV?=
 =?utf-8?B?WDBkSEVCUEJSUG8rUTJldU9sMXNMcDhlNXNPVWN0N3lDanBZYUxLQnRMOTFx?=
 =?utf-8?B?WW85a3NLWFpsMjU2aVpTMDYyWjRXaHBNWU9JMlA2ZFhudVJNd0lHT0dIbGUv?=
 =?utf-8?B?ZW1VSG16L3NtQ2svRDJ6U0I3VXE5dENsQWk0Vm81NXlCQXVaV2VhemFpZDBh?=
 =?utf-8?B?S0JmRTdZeE5QR0FBS2hZMDBwK3lIYWluazFvQmszU3ZYbHBMZ1UwYUpwVmVm?=
 =?utf-8?B?Ty84ZDFRcHkveVVCMSttWi9iL2MyTWsxYTUzZmtDbHdNZDZ3ZDZ4RWdkK3FL?=
 =?utf-8?Q?Bb2pNvy8WmDfkpXAYl/Ezb91b6YYQn00s+BHC+5huoXMF?=
x-ms-exchange-antispam-messagedata-1: sKICV2LMqHZsr3yf7L4IU8dZSTEMc56fQe0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06FE83388D68424EB0D13969703327C1@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	oDqhmg3mgi1zQ1ffDCAuY6aC8eKivOIowcjg8xe3yXaUjUyXuzUlwmS96ThZqzERX+B3auG/o/LdDAI+H8uIR+lcr3k2wJTaWpU5VGNDu4JQlbB/8HHF+uSqgrGUTD8+DzquHIg+OokUA32QL4ckrEFtfopU+EpsoSVvz/9x8OjepKJDOQgF/ZT95lNhtlmPJ8EaEZJPFR8VsH9jfrpK+pu7Sh5WXVfhddCRpKylaEi8dWizioJ/Rp/6TkRdAXJL6BuMbc3nhZQWn1pKG2NhGwDQuYMH8qsNg1+3E6MGBWglOGF/+T3gJGjnktSdr69Z0g8peCyUSu4nd9DOv/S7Gg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d03dce-30fa-4667-70fd-08dea9eae8db
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 14:39:12.6757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9H4NzAIo24WcPvCrtP6tA4iCcx4WQysipg/R79ltC01OgDwhcuiRfsC3rBJ7Sdtyc0apXRy7HH3WfBVMXt2dGXenGFwhMncFUrOP0HNEobs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8672
X-Proofpoint-GUID: EYraMy4sz9ujTYKZ2rIDh4OU2o4mxofs
X-Proofpoint-ORIG-GUID: EYraMy4sz9ujTYKZ2rIDh4OU2o4mxofs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1MCBTYWx0ZWRfX5JsfpRzAvez0
 WWbSJqK1eej2zilc1A/s07W4dpUBE8GGy/GU9euqR1lV4HVdf/KBU2FH0XU5QGyAUPsGbLIwUD5
 pbfJvmx5rRWQtg3hoOvQzsYXLCBnYGUybdFlYeyxYdXQnmZ7fjwoOIP5aScGrqtpTxqMveBF7to
 nXPYRff/f7Me24bQ/uPECoT+1+b42UnmJAEM1xt7U/p9XRu5o+2uUGkVAAjwF4M3Z7pOGoIBUvS
 Es7sQPlP7vyMWXow963pyvHWfIvbu0tHryi8QQ356LRGqI9ff2uiF6R625YOFVNln5Fn4A33Av9
 3C8qXSpQOUhO82U5YGqEj/4ChR8u3re/u81U+N++UCxONOqZrlODuS+cu4rZ1vzNl5czo0E+RID
 uEgf7UyaeNMwCknvwwki1VKCdTPDYaMEAkPL1TADcpnQ6Gf90F5ql1X5F7aedVSFT2IOtbCikMw
 6x1se/tI29ynoRcHyWA==
X-Authority-Analysis: v=2.4 cv=LJNWhpW9 c=1 sm=1 tr=0 ts=69f8af94 cx=c_pps
 a=zawiyoErqgptCln8LtCPNw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=3Nk4j934AAAA:8
 a=uICUvMojAAAA:20 a=VwQbUJbxAAAA:8 a=CT7pYnU4XIlFaqwlkc8A:9 a=QEXdDO2ut3YA:10
 a=GnnOGohabkFYx92mCEIS:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
X-Rspamd-Queue-Id: 8941D4C045F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nutanix.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nutanix.com:s=proofpoint20171006,nutanix.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6259-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,copy.fail:url];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nutanix.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jon@nutanix.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	APPLE_MAILER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]

DQoNCj4gT24gQXByIDI5LCAyMDI2LCBhdCA5OjE14oCvUE0sIEVyaWMgQmlnZ2VycyA8ZWJpZ2dl
cnNAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBBRl9BTEcgaXMgYWxtb3N0IGNvbXBsZXRlbHkg
dW5uZWNlc3NhcnksIGFuZCBpdCBleHBvc2VzIGEgbWFzc2l2ZSBhdHRhY2sNCj4gc3VyZmFjZSB0
aGF0IGhhc24ndCBiZWVuIHN0YW5kaW5nIHVwIHRvIG1vZGVybiB2dWxuZXJhYmlsaXR5IGRpc2Nv
dmVyeQ0KPiB0b29scy4gIFRoZSBsYXRlc3Qgb25lIGV2ZW4gaGFzIGl0cyBvd24gd2Vic2l0ZSwg
cHJvdmlkaW5nIGEgc21hbGwNCj4gUHl0aG9uIHNjcmlwdCB0aGF0IHJlbGlhYmx5IHJvb3RzIG1v
c3QgTGludXggZGlzdHJvczogaHR0cHM6Ly9jb3B5LmZhaWwvDQo+IA0KPiBUaGlzIGlzbid0IHN1
c3RhaW5hYmxlLCBlc3BlY2lhbGx5IGFzIExMTXMgaGF2ZSBhY2NlbGVyYXRlZCB0aGUgcmF0ZSB0
aGUNCj4gdnVsbmVyYWJpbGl0aWVzIGFyZSBjb21pbmcgaW4uICBUaGUgZWZmb3J0IHRoYXQgaXMg
YmVpbmcgcHV0IGludG8gdGhpcw0KPiB0aGluZyBpcyB2YXN0bHkgZGlzcHJvcG9ydGlvbmFsIHRv
IHRoZSBmZXcgcHJvZ3JhbXMgdGhhdCBhY3R1YWxseSB1c2UNCj4gaXQsIGFuZCB0aG9zZSBwcm9n
cmFtcyB3b3VsZCBiZSBiZXR0ZXIgc2VydmVkIGJ5IHVzZXJzcGFjZSBjb2RlIGFueXdheS4NCj4g
DQo+IFRoZXNlIGlzc3VlcyBoYXZlIGJlZW4gbm90ZWQgaW4gbWFueSBtYWlsaW5nIGxpc3QgZGlz
Y3Vzc2lvbnMgYWxyZWFkeS4NCj4gQnV0IHVudGlsIG5vdyB0aGV5IGhhdmVuJ3QgYmVlbiByZWZs
ZWN0ZWQgaW4gdGhlIGRvY3VtZW50YXRpb24gb3INCj4ga2NvbmZpZyBtZW51IGl0c2VsZiwgYW5k
IHRoZSB2dWxuZXJhYmlsaXRpZXMgYXJlIHN0aWxsIGNvbWluZyBpbi4NCj4gDQo+IExldCdzIGdv
IGFoZWFkIGFuZCBkb2N1bWVudCB0aGUgZGVwcmVjYXRpb24uDQo+IA0KPiBUaGlzIGlzbid0IGlu
dGVuZGVkIHRvIGNoYW5nZSBhbnl0aGluZyBvdmVybmlnaHQuICBBZnRlciBhbGwsIG1vc3QgTGlu
dXgNCj4gZGlzdHJvcyB3b24ndCBiZSBhYmxlIHRvIGRpc2FibGUgdGhlIGtjb25maWcgb3B0aW9u
cyBxdWl0ZSB5ZXQsIG1haW5seQ0KPiBiZWNhdXNlIG9mIGl3ZC4gIEJ1dCB0aGlzIHNob3VsZCBj
cmVhdGUgYSBiaXQgbW9yZSBpbXBldHVzIGZvciB0aGVzZQ0KPiB1c2Vyc3BhY2UgcHJvZ3JhbXMg
dG8gYmUgZml4ZWQsIGFuZCB0aGUgZG9jdW1lbnRhdGlvbiB1cGRhdGUgc2hvdWxkIGFsc28NCj4g
aGVscCBwcmV2ZW50IG1vcmUgdXNlcnMgZnJvbSBhcHBlYXJpbmcuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGtlcm5lbC5vcmc+DQo+IC0tLQ0KDQpRdWljayBw
YXNzaW5nIG9ic2VydmF0aW9uDQpJIG5vdGljZWQgdGhhdCB3aGVuIGF0dGVtcHRpbmcgdG8gY29t
cGxldGVseSBkaXNhYmxlIHRoZXNlIENyeXB0byBBUElzLA0KSSB3YXMgZXhwZXJpZW5jaW5nIGJv
b3QgZmFpbHVyZXMgd2l0aCBmaXBzPTEgZW5hYmxlZCBzeXN0ZW1zLg0KDQpVc2luZyA2LjE4LWJh
c2VkIGtlcm5lbCB3aXRoIGFuIGVsOS1iYXNlZCB1c2VyIHNwYWNlLCBJIHNlZSB0aGUNCmZvbGxv
d2luZyBoYW5nIGluIHRoZSBlYXJseSBib290IGNvbnNvbGUgZnJvbSBkcmFjdXQtcHJlLXBpdm90
Og0KICBDaGVjayBpbnRlZ3JpdHkgb2Yga2VybmVsDQogIGxpYmtjYXBpIC0gRXJyb3I6IEFGX0FM
Rzogc29ja2V0IHN5c2NhbGwgZmFpbGVkIChlcnJubzogLTk3KQ0KICBBbGxvY2F0aW9uIG9mIGht
YWMoc2hhNTEyKSBjaXBoZXIgZmFpbGVkICgtOTcpDQoNCkkgaGF2ZW4ndCBsb29rZWQgYXQgZXZl
cnkgZWxYIHZlcnNpb24sIGJ1dCBhdCBsZWFzdCBpbiBlbDkgYW5kIGVsMTAsDQp0aGV5IHVzZSBs
aWJrY2FwaS1obWFjY2FsYyB0byBwcm92aWRlIHNoYTUxMmhtYWMsIHdoaWNoIGRyYWN1dCBbMV0N
CnVzZXMgdG8gY2FsY3VsYXRlIHRoZSBITUFDIHZhbHVlIGluIGRvX2ZpcHMoKS4NCg0KRGlnZ2lu
ZyBmdXJ0aGVyLCBJIHdhcyBvbmx5IGFibGUgdG8gZGlzYWJsZSBSTkcgYW5kIEFFQUQgQVBJcywg
YnV0DQpub3QgSEFTSCBhbmQgU0tDSVBIRVIgQVBJcyB3aGVuIEZJUFMgd2FzIGluIHRoZSBwaWN0
dXJlIHdpdGggZWw5KysuDQoNCknigJltIG5vdCBzdXJlIGhvdyBvdGhlciBkaXN0cm9zIGRvIHRo
ZSBzYW1lLCBidXQgdGhpcyBjb3VsZCBiZSBwcm9ibGVtYXRpYw0KZWxzZWh3ZXJlIGlmIG90aGVy
IGRpc3Ryb3Mgd2VudCBkb3duIHRoZSBsaWJrY2FwaSByb3V0ZS4NCg0KWzFdIGh0dHBzOi8vZ2l0
aHViLmNvbS9kcmFjdXRkZXZzL2RyYWN1dC9ibG9iLzA1OS9tb2R1bGVzLmQvMDFmaXBzL2ZpcHMu
c2gjTDE2Nw0KDQo=

