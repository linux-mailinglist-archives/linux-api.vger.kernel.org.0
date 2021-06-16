Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9EA3A9B41
	for <lists+linux-api@lfdr.de>; Wed, 16 Jun 2021 14:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhFPM62 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Jun 2021 08:58:28 -0400
Received: from mail-db8eur05on2054.outbound.protection.outlook.com ([40.107.20.54]:27137
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232550AbhFPM6Y (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 Jun 2021 08:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNqoL0HL8R0kb7AWjuFxlgNNGn1MRNEwkjwuXd+f7HE=;
 b=8PTOL5SR3uVs4vkwP4az0+9SJqRQFQLALzdxr8LnEQSiwqM3897x9UM04pQxEs1+RdDztVLTnDrwEQoFRzlLzK9cBQZbi1heSRLKzPb6fXg3o1Y2p0lx2oyzvzrJPMe6QTELcFJB+bEllm0xgqY7P4DzjZzNiNFKMC24UDB5C8c=
Received: from AM7PR04CA0013.eurprd04.prod.outlook.com (2603:10a6:20b:110::23)
 by AM4PR0802MB2338.eurprd08.prod.outlook.com (2603:10a6:200:63::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Wed, 16 Jun
 2021 12:56:16 +0000
Received: from VE1EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:110:cafe::7c) by AM7PR04CA0013.outlook.office365.com
 (2603:10a6:20b:110::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Wed, 16 Jun 2021 12:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT042.mail.protection.outlook.com (10.152.19.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 12:56:14 +0000
Received: ("Tessian outbound 596959d6512a:v93"); Wed, 16 Jun 2021 12:56:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 442c89f34507cde8
X-CR-MTA-TID: 64aa7808
Received: from f08631b6cba3.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 55CB67C4-3E85-4974-A7CD-7AFC8D7C924A.1;
        Wed, 16 Jun 2021 12:55:50 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f08631b6cba3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Jun 2021 12:55:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYo6nWhohR7SH5yqOsmnZnUMpPuL7PnNszok5HSa04XeExpgIDlaYknEinAn2dqWZ6vgYYibHuWdJeZkb2MzG9Q3kzNJwaJE0yYLN2zm10Dx5Hd2AGmbdjYXvzrQbqiv+N2IEV4WK5cRoIK9yfzqNq0vsUbA8uce4VR1PND9FEkxw2w5FP/ppoMDHTDpMZ+Ib52uEmknKpCZ3N93d/723BWHZjaGeMPDW8csbvb8igDJGU6SoZ1vJlVzY3IkyYF3Bi++3mfF8wD+BAr3jD1Gyf1wAEzpon2VrZU1rnG6uxQwq5rrTVwIf0L4+J4wSXEAKeBAoK32eh6nxvd8+9pLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNqoL0HL8R0kb7AWjuFxlgNNGn1MRNEwkjwuXd+f7HE=;
 b=gypcYB3wSv6kR0Lb7t4dNKYwR4f8ZlaOXA5dUc0frM9/PFKdGRWQeeCThGEenoKDIVXdIzzf7/FaPyotshvzxSe61NW60ea/GY6SU+SFqSb9M09LYr0/oEBNw/zR1POyeUpzudGH71oZ30+0+E4xHDE5XYpbOhuNWekMRfceGA89le1ZgpYkHFnubp92W26+/qfeQrg/VaEhH3Z73vwmRREzIo7f4NxvqnN8SyFrogjgDamZvWIwhJu41uTsaeN24HBet3Ist8Y2kNA8cqdKI/liO/LvFhoRcQJrMPB7RdwBcXuAIoVntS8cButcEJ2VW25HAgAiHo+RIQo9W9JcRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNqoL0HL8R0kb7AWjuFxlgNNGn1MRNEwkjwuXd+f7HE=;
 b=8PTOL5SR3uVs4vkwP4az0+9SJqRQFQLALzdxr8LnEQSiwqM3897x9UM04pQxEs1+RdDztVLTnDrwEQoFRzlLzK9cBQZbi1heSRLKzPb6fXg3o1Y2p0lx2oyzvzrJPMe6QTELcFJB+bEllm0xgqY7P4DzjZzNiNFKMC24UDB5C8c=
Authentication-Results-Original: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
Received: from PA4PR08MB6320.eurprd08.prod.outlook.com (2603:10a6:102:e5::9)
 by PAXPR08MB6927.eurprd08.prod.outlook.com (2603:10a6:102:133::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 16 Jun
 2021 12:55:46 +0000
Received: from PA4PR08MB6320.eurprd08.prod.outlook.com
 ([fe80::e5bd:60d4:dce0:7d63]) by PA4PR08MB6320.eurprd08.prod.outlook.com
 ([fe80::e5bd:60d4:dce0:7d63%6]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 12:55:45 +0000
Date:   Wed, 16 Jun 2021 13:55:43 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux API <linux-api@vger.kernel.org>, nd@arm.com
Subject: Re: [PATCH 2/2] arm64: allow TCR_EL1.TBID0 to be configured
Message-ID: <20210616125543.GE12580@arm.com>
References: <20f64e26fc8a1309caa446fffcb1b4e2fe9e229f.1605952129.git.pcc@google.com>
 <64c0fa360333fd5275582d25019614156a8302bc.1605952129.git.pcc@google.com>
 <20201124184742.GC42276@C02TF0J2HF1T.local>
 <CAMn1gO7G=s7pHFf3jNLj6tZyRuRDvpC2_o=oNWEi4h902hnj6g@mail.gmail.com>
 <20201125143753.GO20578@arm.com>
 <CAMn1gO7r2EYN0VPxpHJwTV5dVOtbKGhC2GsXHBbNnr4NTvt37Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMn1gO7r2EYN0VPxpHJwTV5dVOtbKGhC2GsXHBbNnr4NTvt37Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.55]
X-ClientProxiedBy: LNXP265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::32) To PA4PR08MB6320.eurprd08.prod.outlook.com
 (2603:10a6:102:e5::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by LNXP265CA0092.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Wed, 16 Jun 2021 12:55:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73abb2eb-d624-413c-c186-08d930c61ff0
X-MS-TrafficTypeDiagnostic: PAXPR08MB6927:|AM4PR0802MB2338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0802MB23380BB453FB648A1F834007ED0F9@AM4PR0802MB2338.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3xL6HZBF8pzeu6F7BjlJq0t4T/J1XEz8Jsn8Aqj/oF5SFGb3swPr5gd9uw4luW9qa5m4TVzfx69qOUsAb975e2fxiqtoSVFnt7ey7RBp7Jbmph/p/sUKFj3RoFU9R/NOe88DyLxKlJA7NZ+kkCREAI4W0eyV5xl/tKNirnoQ6qzk7JbrB9TlAEyxuYZi+IuJJOJVnxgkp/tIZ4SK3itmotJ2RMpy8JMw6jW5GVu8OFt0N1Etcs091F1F33FFGVHdt9T9Qt4UWkrpbQGl6IAaKmKs2AC307EZD7pd17QtAQaTIcVirhRS/oasl0pAfljtbmlefnwWMzrqSHcTmUHFkRQmLOM+O6BI0lHWgSPjf8elCVlPPhn9UGlv1xTup6V+FFbfwPl7embkxxrGbWvDjvxd4s9AyPb+UULzEpaHu+YI1cofY5cxQwMY3sTMLpSNQDTa5Xv9I7ImzIZezEme4c6KycuzXB42KzxCXT+9gfC+k6cjlcYnTf5zK/UQFYqK7ndYCd/FNW47iEOF2UrkeQPfMLq4SSHs3AJL/3wqF5byRqoBMihzDFay35dFJFrzbMwE7gRb6HunxJcGzbkF2Z2KZHTDRgJfRlot2QObOuoyWYbkwfF7ztSLoGzgDnQEEbKulwr7XNtn3XPiidKOnisKPpioTY7b+Xe+CDl/O+7jT7f095ECHOpaWVM+5xFzaqdwzG/JmYsH+qqOEh71GEUluXA9Vk11bZNfvu30yEdMsf1kbWXJ1ATvTh8ljM9G/R41DBfpPmUW4fg8G1DNYw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB6320.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(5660300002)(44832011)(6916009)(83380400001)(38350700002)(38100700002)(55016002)(36756003)(53546011)(316002)(8886007)(66556008)(1076003)(66476007)(966005)(478600001)(956004)(8676002)(33656002)(4326008)(66946007)(86362001)(54906003)(2616005)(16526019)(7696005)(26005)(186003)(52116002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1ZjU2N1bXY1bFdsVWVnby80Ry9XNGhQY1RlblVIVy9xelZtellXbGlmTlpQ?=
 =?utf-8?B?K2J3YTJDMjZwdjhJdUN2SmdTaytWZzZGYVBzS1FsbmROc25VVWFYY3VnaWF1?=
 =?utf-8?B?cE1GTHh5WnVCZ0JLeGFhZjhsVGNpcldOTDNUdXlwZXhDOWZxcHRubkk0TzZC?=
 =?utf-8?B?SE5DYVN5MlYycFBUYkZNdjZqb1FnYVFocGpaZXlZOFc2NUhJYnAzZDlWdW91?=
 =?utf-8?B?TXpURlAxQU0vSytPOTNrL0JzRzdKc3lISVYxbTJkb0NQR0NEU3ZJbk1PNUVV?=
 =?utf-8?B?RUphRmprSEF1NzJFdXRibWYrMnFQYVQwUnUyZnlsdGRrRklMdWNPVmRCU0xv?=
 =?utf-8?B?dHF4bjFTVm14bGFXTmZVTzl6VXNmTlBQdTJTS2VUek80NitwMzd4aHBPNDFI?=
 =?utf-8?B?VmZEdkFNQnNja1Jad1pmbDY2V1ZrRXE2VEZTandXdFZrdHkzRlNKMlUvNnU0?=
 =?utf-8?B?UG8yNlNrY1pLVjRVVUJTbmljQm1VNGFBNGUvTnlsSktBeHRTVUl4WThRRlM1?=
 =?utf-8?B?cVpNVUhvdWkyanNOakhMYkE4YmtSUktDTFQ2TmpsZGMyNE13SS9YZlRrRFlB?=
 =?utf-8?B?ZEEzeWZaaGNZRWswUWVmaW5RSFEyclN1czJOTGdiTDNrS0poS09iVDBhR0Fk?=
 =?utf-8?B?T0lDcWNPcERIV2VaaWVpRXlZdDdMK29uN2xOZVdyaDh4aWtMc3RjMGwyVFV5?=
 =?utf-8?B?blI2Q3pRUG9xSzYrajNTbVdOTnBsZ2QyYkpCT1o0eHRHRnVkb1FoUWZGd09Y?=
 =?utf-8?B?TTNmMkJIZmlNeWtqOGUrbnk0L2dKNElPcUMrQ3RkeFhCbXNLdUNJQXR5MDVw?=
 =?utf-8?B?a0NQanUzd3IzNGFkQXhUQjhDb2VuQzhTNlp2aWhHOG1Yb1NEY1A2VXRUSkll?=
 =?utf-8?B?YzhNamQza1R6YnVDZlFmUHFEWjJZWUZaK0lLTVFQSU02SFZvMFNWaCtvVTVV?=
 =?utf-8?B?cWZEZ2VFSXVWczhVTGc5aldEa09laXJYY2J1US81aVJjQ010TC80enpmekt0?=
 =?utf-8?B?aVVuZzZDWnNjMm5pMUJTb29jUHhBZ2NrQU1BYnhTN0lWRUszVHliSE5ubVNa?=
 =?utf-8?B?Y3VCRE80ejNBUmg0aHRCeUVPcUg1R3g1WTNSaFFnTGFmS1h0dFRmdG1wV1Rq?=
 =?utf-8?B?VjNzK3NNdVoyWjBFd2NOdWQzUXJVUDZaYU11OS8ya3NLWFIyN01HYmZidTZX?=
 =?utf-8?B?MEpZYWhEZUg1ZnFvREttZ3hHZm8wT25TN0FNWUZqVHA2eFlCRXFRa2tjYjFj?=
 =?utf-8?B?TXF2SVpyY0hzTURrYk5vZmUrcEI5bnIxdzkzS0hhSHkwZEpDdmp2OXlKTjdy?=
 =?utf-8?B?Q21rRE9oS1dDNkJtSXNIV3ZxMXVJVDB0NkRBdktuY3hVMWlHV0RiaHdjOWJy?=
 =?utf-8?B?eDBiSWQ0d3Bna0tsQU5RTDRxVTZ5RWY5UWZMSGFWM01Xdml0cFV2aDlyaTJB?=
 =?utf-8?B?RHFJdFpmUlF4bFZ6WWd1M1dnQkhjeFFUWE5pTVBWRHk2WlhHRVdPQmlwM2g2?=
 =?utf-8?B?NDd2dDBtYzlJRUt1QTNHTktDNFJCanVQMFdIbUVGTXNGaFRnc2ZQODdrQVpl?=
 =?utf-8?B?d0hhQ0psZW5NQ2Z6d0k5K25pcE1lWHVhODJSOENDcHJ6anc5N3FBMVVreEx1?=
 =?utf-8?B?YXhNTm9iRzFjcG8xUmRlc2p3V2JKb2o2WERzTXR4VjdPSXh4MFdPMFJJS2d1?=
 =?utf-8?B?Q3crTjlUR2dRN0tLV2lURmFiM0VUT2FyZEUwZ3MrTDJaUjVyblA1cUJ6bGJF?=
 =?utf-8?Q?ID0Lyc99YrUqiJfVWrofuSd9P6iglkktZvPskbi?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6927
Original-Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: c46c1093-c2a9-486e-65a7-08d930c60e7c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjJT87NciyUPrk5D/tmwQiOL59AgM/hX1en+8Vq5dEqTSRbl3LQ5qNSwiO6R1Htlqy3ELkpSpMk1DgDkV2/WlgY21L7BN/i+t7ISKjGiN8mfMtyH6+HpfaHDpcZhoa24SFqHTqnyWXdOHSWJoDo9e2/oIuGOROqLsArfatHukuuGT9X2AFkmUt9kY4psMJzQ3Lqfof9lh8+MiyNXNVj0VBAoalBCbuMQNCL/hUPgsOhiw1e29SeAZSoPTZsELfefQo1Dd+DzZ4ekkDINqfmtNyyd6gNlGJ/SHmELzp5wj4VtXyQvqCbaaARt9XZ9PgSA9q0ZgtiXlZl/+dQDBaJzC0UGdqrQvt+XFZrVo74qVX12oFWKxMkLDPwjYrGYqTfzhnXEYncT/3NP/1LbXssgA/KFYtADXZdxseNOKKpxhWZvY2XnDL2L7SLGw/CysuxI5UO5YHFPa3GTvs7CAHYGnbX0qb3gYf9kPSUzOnis0E0PU9WFuK/ZjKv0UplIvKUqe2k8frJJdOrwH2QqYITKBpZ8S69iKat75gNv7lJNefCJ0z2jFS5AVMAD/eP1qlNZpGZwdPLNYy3XYaBGoOt8EWZqpQQvNoX9WdotteCyRXzorvMKtY2TEs5KS4Fqu+o7bagsKXIJjdxsrxkWLrbOjZLjAwa83QIp98j8P4JSEZY1Ugxco8J82qokKYUgiADs2y97COMydR2GyBIunUMG2B+ej0MculWS5K8syqgEUh6LZnJeemu+ZIwYSEccixFar63aWXvI+UMObGOgettpUg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(5660300002)(55016002)(7696005)(356005)(6862004)(86362001)(47076005)(53546011)(83380400001)(33656002)(82310400003)(70586007)(70206006)(8676002)(1076003)(186003)(36860700001)(2616005)(8886007)(478600001)(26005)(44832011)(54906003)(82740400003)(966005)(4326008)(8936002)(336012)(2906002)(81166007)(36756003)(16526019)(316002)(956004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 12:56:14.5496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73abb2eb-d624-413c-c186-08d930c61ff0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2338
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 06/15/2021 16:41, Peter Collingbourne wrote:
> On Wed, Nov 25, 2020 at 6:38 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
> >
> > The 11/24/2020 11:18, Peter Collingbourne wrote:
> > > On Tue, Nov 24, 2020 at 10:47 AM Catalin Marinas
> > > <catalin.marinas@arm.com> wrote:
> > > > On Sat, Nov 21, 2020 at 01:59:03AM -0800, Peter Collingbourne wrote:
> > > > > Introduce a Kconfig option that controls whether TCR_EL1.TBID0 is
> > > > > set at boot time.
> > > > >
> > > > > Setting TCR_EL1.TBID0 increases the number of signature bits used by
> > > > > the pointer authentication instructions for instruction addresses by 8,
> > > > > which improves the security of pointer authentication, but it also has
> > > > > the consequence of changing the operation of the branch instructions
> > > > > so that they no longer ignore the top byte of the target address but
> > > > > instead fault if they are non-zero. Since this is a change to the
> > > > > userspace ABI the option defaults to off.
> > > > >
> > > > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > > > Link: https://linux-review.googlesource.com/id/Ife724ad708142bc475f42e8c1d9609124994bbbd
> > > > > ---
> > > > > This is more of an RFC. An open question is how to expose this.
> > > > > Having it be a build-time flag is probably the simplest option
> > > > > but I guess it could also be a boot flag. Since it involves an
> > > > > ABI change we may also want a prctl() so that userspace can
> > > > > figure out which mode it is in.
> > > > >
> > > > > I think we should try to avoid it being a per-task property
> > > > > so that we don't need to swap yet another system register on
> > > > > task switch.
> > > >
> > > > Having it changed per task at run-time is problematic as this bit may be
> > > > cached in the TLB, so it would require a synchronisation across all CPUs
> > > > followed by TLBI. It's not even clear to me from the ARM ARM whether
> > > > this bit is tagged by ASID, which, if not, would make a per-process
> > > > setting impossible.
> > > >
> > > > So this leaves us with a cmdline option. If we are confident that no
> > > > software makes use of tagged instruction pointers, we could have it
> > > > default on.
> > >
> > > I would be concerned about turning it on by default because tagged
> > > instruction pointers may end up being used unintentionally as a result
> > > of emergent behavior. For example, when booting Android under FVP with
> > > this enabled I discovered that SwiftShader would crash when entering
> > > JITed code because the code was being stored at a tagged address
> > > (tagged because it had been allocated using Scudo's MTE allocator).
> > > Arguably software shouldn't be storing executable code in memory owned
> > > by the allocator as this would require changing the permissions of
> > > memory that it doesn't own, but from the kernel's perspective it is
> > > valid.
> >
> > it might be still possible to change this abi on linux by
> > default, but i don't know what's the right way to manage the
> > abi transition. i will have to think about it.
> >
> > i dont think PROT_MTE|PROT_EXEC is architecturally well
> > supported (e.g. to have different colored functions or
> > similar, pc relative addressing doesn't work right).
> >
> > (tbi for instruction pointers is unlikely to be useful, but
> > extra 8 bits for pac is useful. i think we should be able to
> > move to an abi that is compatible with either setting.)
> >
> > (i think supporting mmap/munmap/madvise/mprotect on malloced
> > memory is problematic in general not just with heap tagging
> > so it would be nice to fix whatever jit that marks malloced
> > memory as executable.)
> 
> Hi Szabolcs,
> 
> Did you get a chance to think about this?
> 
> I propose that we start with a command line option that defaults to
> off. If/when any ABI transition happens we can change the default.

a default off per boot option sounds safe even if
there are some incompatible binaries.

(i assume virtualization works: host and guest can
have different settings, so users can always run
old systems in kvm.)

however it would be nice to make this part of the
linux platform abi and avoid fragmentation.
the difficult bits are

- unclear trade-off: does the abi change have
  adverse effect on potential tbi/mte/.. use?
  or even existing usage? (data only tbi is a
  more complicated concept than plain tbi)

- incompatibility cannot be statically detected.
  (toolchain cannot diagnose or enforce it,
  it is only detectable at runtime, on a system
  with the changed setting.)

i think in c the usability of tbi is very limited
now. the libc and compiler needs a tbi abi for it
to work (e.g. different tags on pointers to the
same object break pointer comparision). if tagged
pointers are not dereferenced and don't escape
then tbi is not needed. so only custom runtimes
and implementation internal tooling like hwasan
or heap tagging can use it. arbitrary user tagged
pointer is not supported in libc now.

there is glibc discussion about the libc tbi abi
because intel LAM needs it too, i don't know yet
how that will work, but we can try to make it
compatible with the new setting and roll that
out as the right way to use tbi.

