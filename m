Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D501BD79F
	for <lists+linux-api@lfdr.de>; Wed, 29 Apr 2020 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgD2Iwf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Apr 2020 04:52:35 -0400
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:34539
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbgD2Iwe (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 29 Apr 2020 04:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlS0QDwfIyXqbIw+nIPX06YEoVDj4CTzVVQkvwFgWMc=;
 b=C+52b14dkg1eLvhHLlJDtDikrmCEhfq/ife5ZHsOPtiMOf/FwnYsZjxvta6KP2IsSwbGjf5TaNZHhGWlLHJw5I66oYhS7QCHtK3MLAW4QhxkbQ1jcT5IsoxIFPZHXz+3fLQsPjaseHfJaI45QvRwwgluD2dvcetgsBAsJlz/tMg=
Received: from DB6PR0202CA0032.eurprd02.prod.outlook.com (2603:10a6:4:a5::18)
 by AM6PR08MB3223.eurprd08.prod.outlook.com (2603:10a6:209:4d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 08:52:22 +0000
Received: from DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::8d) by DB6PR0202CA0032.outlook.office365.com
 (2603:10a6:4:a5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Wed, 29 Apr 2020 08:52:22 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT009.mail.protection.outlook.com (10.152.20.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Wed, 29 Apr 2020 08:52:22 +0000
Received: ("Tessian outbound e88319d7ccd0:v54"); Wed, 29 Apr 2020 08:52:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 54bbb451059bca91
X-CR-MTA-TID: 64aa7808
Received: from 21e1746cfba3.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A2119929-D216-445C-A628-CD1CAD360A2D.1;
        Wed, 29 Apr 2020 08:52:17 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 21e1746cfba3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 29 Apr 2020 08:52:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KN9/iAmW6twxTIGcFqu6l6QpPZLAwbmrbBEs4e84OwqkIBR9wWyZq7vQRNWtKLWgrzE+AnbMwosr0zZPjb8z8HvGoO5vLo5SVlYs2MWFcIbgrK4Pm60uDKTYnG3iRK1hw5l324+ccC2uqXmsAW3b993GAhFLPqsZ6W01l57fKPU8VKGBtmT4DjkVx5SSAJ4ejytQxVCeEx0sucW5DJrEias7F9YC7cfW2J7j+ONSL6T53pYeZJqsa9neXC9AqHFo8/bMI77xtRZBHxhwzI+er3dESTnYEdw0nzOqskLWcyjPFzQ6WrJOfG88KDYHG7PPRe0BIxXQevaqi7gjP8kHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlS0QDwfIyXqbIw+nIPX06YEoVDj4CTzVVQkvwFgWMc=;
 b=l1gCaBVDKxi5Nxeq0HTyMcfrnH9tf+07w6Cyxi5lKmJuiHU37pLEmCxZLCm5g+15UExj6vRSXQa1VrNKSybZDYmGA5RMuOEo8/+NIiWS4hleo6nCEzfU/YqaD5np18Yx46pj6p1l3ySb4taZ+YRm7t33pDaPUYUaOyeWUzSonvmi6CDsBXVlVurIcmr1VNj/OHxbywxQGShLSCiEgYH0jCDxA7zCdAH0pkjOR64VdregIA3pLa2QplBV0h7O8obWygPSSPO1fSDTq+xLFwkMeTObBtAq7mVCbfnqJ4ZUTDEMhTch24AEX/935GPLMgYSLvo/SsSXCUtIAvS9NnwQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlS0QDwfIyXqbIw+nIPX06YEoVDj4CTzVVQkvwFgWMc=;
 b=C+52b14dkg1eLvhHLlJDtDikrmCEhfq/ife5ZHsOPtiMOf/FwnYsZjxvta6KP2IsSwbGjf5TaNZHhGWlLHJw5I66oYhS7QCHtK3MLAW4QhxkbQ1jcT5IsoxIFPZHXz+3fLQsPjaseHfJaI45QvRwwgluD2dvcetgsBAsJlz/tMg=
Authentication-Results-Original: deneb.enyo.de; dkim=none (message not signed)
 header.d=none;deneb.enyo.de; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB4817.eurprd08.prod.outlook.com (2603:10a6:20b:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 08:52:14 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.2958.019; Wed, 29 Apr 2020
 08:52:14 +0000
Date:   Wed, 29 Apr 2020 09:52:04 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        carlos <carlos@redhat.com>, Rich Felker <dalias@libc.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C
 startup and thread creation (v17)
Message-ID: <20200429085203.GR29015@arm.com>
References: <87zhawvphv.fsf@mid.deneb.enyo.de>
 <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com>
 <87ftcnrf7d.fsf@mid.deneb.enyo.de>
 <1080028389.72414.1588077193438.JavaMail.zimbra@efficios.com>
 <878sifrdo0.fsf@mid.deneb.enyo.de>
 <190402462.72430.1588077816717.JavaMail.zimbra@efficios.com>
 <87tv13py8j.fsf@mid.deneb.enyo.de>
 <437249723.72685.1588085899422.JavaMail.zimbra@efficios.com>
 <20200429081606.GP29015@arm.com>
 <87a72ug0xr.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a72ug0xr.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN2PR01CA0062.prod.exchangelabs.com (2603:10b6:800::30) To
 AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by SN2PR01CA0062.prod.exchangelabs.com (2603:10b6:800::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 08:52:10 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0eea0482-e6ae-4a65-e687-08d7ec1aa1da
X-MS-TrafficTypeDiagnostic: AM6PR08MB4817:|AM6PR08MB3223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB322331116702773E23B9B70BEDAD0@AM6PR08MB3223.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:628;OLM:628;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(4326008)(33656002)(54906003)(44832011)(36756003)(316002)(8936002)(956004)(2616005)(16526019)(26005)(66946007)(7696005)(52116002)(66556008)(66476007)(53546011)(186003)(2906002)(6666004)(8886007)(1076003)(5660300002)(8676002)(86362001)(55016002)(6916009)(478600001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6Dw3mmLdExP+rFSBELjnZsFkvjZPBFglycVGb6PEF0PCBhDNojgGIqL84SrEOsp1v89NArz3b7ias6HOZ27cioNPNE6OnD77umDxZMN24Zme5ohJ/aGwqs/LPPVVz/kl7waHSfERoRD1PeM1vews+udTTiYLG+2O6EwGOsyyPL5T4X5qf46Nu1WuVdX0XbaoX8nwIe3Jyh5CEM94hMCVklZoujgg0CMlfGgPbfRY68uR/kg15XS+8ECqNYfhZ0cTJlsr7TeaKHRTPs9Fp3HXL5jXFKxu/fs5KPky+uJ0hMRBE7r2axZvHzwkvAjGfFdjxx19wIkm15IQmHP2FLmw33bh83XaBDNBLQvLbCqzZU9Vm7/TTlFKcS0unE/pP4LPmsvQl2m2HQ9PESQZRYIJJzq1qIQUTRUh16Ms+saVvh/DAqFtX7RSpayF3qqwd16h
X-MS-Exchange-AntiSpam-MessageData: HXCU5rbb2kAVXUg/1Z5pTH5WZbq+aZTAfvLs1AyyHwCYvSWkjcJF7vG/RAcLz/kid4imGpO6rTcSnv0zK+rogZf1pRlE+MAdQq/hnDCPDNUOykB+TSoz28Bgu1SR07cNGm0ypBwRZaj2sbwsfPCBJfyJ3wt+dThOt9jFWhxkhLt7h+cg071gThkdl2uC8nzA/aOxPPU9hOtTNhhFesyv7GEACIJCQt9+CRoED8AXws8sdO86oe+QC6gAMeRXQIXQZJwYoQd3kHUYTQ8W9AdlnG/qOIJ1Ts34drcDCdfynEeSe4009fKnYx/YfM/1W0TCLCMKLk3qVfTLJIVCCQhm2A55HwD7QG1R5lKdiZ7LvFN1widSa4FPsygi9SbXZIdiGJswNgdWMiVbn4fk2O488HuB1qyHXrxIas6Rifxe9Y62WF0ISbUu3LUmY0oUoOlkHfC++pB7zLrVvsuAzV0Ht2zqUiJAUlnr7cY63FljpF267ltdZNHX6WLOYHNUkkfOPEyw2XQe8PtL0HN8SXWH3fkG+H0sNpH0Qsf9Z4w5963GbIOJVE7POSqAtuZJXbj3/riD+kgCp3VQo8jV9lHtCDQJJTf3u5r7i8Zu1fR6v6WYXUpRbr0HT3htzQK2QSa6d/GGwA681Pb2r4l0GUDxz8mYBiQapLslpbSPpCX9CxyjEOS4ow7DlKSwnFNhssktMM9FgB4t76kBavhq23aJ2cGuYD8EFq1GSjdZbsPyOB0Knb1cUSfd50ViOF1K9GTAQxsc0fqoeBG/7hM9pR01sSW/y3CV4oW097P1qJ3+W7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4817
Original-Authentication-Results: deneb.enyo.de; dkim=none (message not signed)
 header.d=none;deneb.enyo.de; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(136003)(346002)(376002)(396003)(46966005)(70586007)(6666004)(86362001)(8886007)(356005)(47076004)(186003)(16526019)(81166007)(53546011)(316002)(2906002)(82310400002)(7696005)(70206006)(54906003)(2616005)(956004)(82740400003)(8676002)(8936002)(36756003)(336012)(107886003)(5660300002)(6862004)(33656002)(1076003)(4326008)(44832011)(478600001)(55016002)(450100002)(26005);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d9bd4529-4892-4b2b-01d6-08d7ec1a9d06
X-Forefront-PRVS: 03883BD916
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMjlknhacVb4SDSTc8NoAdpI0hA9JHNZxqWr0eWWUjdKx3zLWBNmnIf7BKmPOdjwJr/9wEMeFzuroMZXbJQvvMfXTZCbAWTBYBqJciXG/a0b6AtI+II/uLV8KAnP08lmemNEJIEavJ/5IwvxZrpTLU+pPiMqUkD3TlNN0dqbp5NUruWQpXyFPGwKq3DwaiHtOp1ucZKTwRVFOXZYARXlE60WeM//y/w5WiX78ee8AHVyUo8683rShReVUm60w7bILFCRtw2pgFagEvg88CsTfg0LIIoSj/vINQRAN+9HU1JEmbclSi73k5XkY4XbOZ4rOBK7tOaNOdaUlo9B3QUi13joz0htJWc4DrcJWGcp+KvYhHahy9aAJOnSsdJK1KbBVRjqJeP30p8YXJOOrnDY6ZMRFNENf+BIiqWordX1qnSyNEsTuuzfJ1W/AMlVVVAHP2OIMFuKmrgOJNjLkkvpiof59Jrii/o8YUa7S15kAUUfTVClwBRIJQDmvkkmPaLArmL2P71IB01m5sz+pcHMDA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 08:52:22.4897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eea0482-e6ae-4a65-e687-08d7ec1aa1da
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3223
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 04/29/2020 10:18, Florian Weimer wrote:
> * Szabolcs Nagy:
> 
> > The 04/28/2020 10:58, Mathieu Desnoyers wrote:
> >> ----- On Apr 28, 2020, at 8:54 AM, Florian Weimer fw@deneb.enyo.de wrote:
> >> > That one definitely should work.
> >> > 
> >> > I expect you might see this if libgcc_s.so.1 is installed into a
> >> > multiarch subdirectory that upstream glibc does not search.  (The
> >> > Debian patches are unfortunately not upstream.)
> >> 
> >> My test environment is a Ubuntu 18.04.1 LTS.
> >> 
> >> > 
> >> > I think on my system, the built glibc can find the system libgcc_s via
> >> > /etc/ld.so.cache, so I haven't seen this issue yet.
> >> 
> >> On my system, libgcc_s is provided here:
> >> 
> >> /lib/x86_64-linux-gnu/libgcc_s.so.1
> >> 
> >> by this package:
> >> 
> >> Package: libgcc1
> >> Architecture: amd64
> >> Version: 1:8.4.0-1ubuntu1~18.04
> >
> > before running the tests
> >
> > cp `$CC --print-file-name libgcc_s.so.1` glibc/build/dir
> > cp `$CC --print-file-name libstdc++.so.6` glibc/build/dir
> >
> > so those toolchain libs are in the search path
> > of the newly built libc when running tests.
> 
> Do you actually see the need for these steps yourself?
> 
> I guess the correct fix would be to upstream the Debian multiarch
> changes and activate them automatically with a configure check on
> systems that use multiarch paths.

cancel tests work for me on an ubuntu system because
of /etc/ld.so.cache, but that may not be present
or the system may not be glibc based at all.

i always do the cp because i build gcc myself (usually
close to current master) and don't install it to the
system path which means at compile time and runtime
different libraries are used if i dont copy
