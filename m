Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B69B2B9046
	for <lists+linux-api@lfdr.de>; Thu, 19 Nov 2020 11:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgKSKkQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Nov 2020 05:40:16 -0500
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:64433
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbgKSKkQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Nov 2020 05:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pyKGstONSSIZ7o5hTvaLgBHLfkZFGfI27IGZ+mAD1E=;
 b=tcJCJOnKxFpDarK037kwk8qlBDEY0W1zTVssH7rit3+vapbk+IrqKwRg2fRgzsMJXxk9SIspm7oYkIxzsscNEuKbgZAhP2GEi/QTiSchl5wZ+s3EzT40Lnxbg+EK9TyVMSqQbUCffAFZoEjzQjoy9TJT1aL7ZBs7Tjm0SCEeifc=
Received: from MR2P264CA0039.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::27) by
 AM4PR0802MB2356.eurprd08.prod.outlook.com (2603:10a6:200:65::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Thu, 19 Nov
 2020 10:40:10 +0000
Received: from VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:0:cafe::43) by MR2P264CA0039.outlook.office365.com
 (2603:10a6:500::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Thu, 19 Nov 2020 10:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT035.mail.protection.outlook.com (10.152.18.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 10:40:10 +0000
Received: ("Tessian outbound 797fb8e1da56:v71"); Thu, 19 Nov 2020 10:40:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d623d293876f4194
X-CR-MTA-TID: 64aa7808
Received: from 7767efde31b4.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FCFBF53B-C1FA-428F-BD5D-62B75A9B112C.1;
        Thu, 19 Nov 2020 10:40:03 +0000
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7767efde31b4.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 19 Nov 2020 10:40:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crBkaBFXCkub/FTXpQcSP/XbJ8cfu7v5g9Vt3wkB6IX9z0dWsE/Efmv4LsYtaOpi1VOFIvpNYqt9RH23QFj7yN9bOeXjZv9XV5Amd5LB8wrUr7k7BDE9ReYrj9Ur6qXiVPYQp6zrDqFU7vMhIqUB+Dh1dDMwp186RlUh07/JZTumilPVuy7mCnOngVn/6BZ2K7d7K3MDOxDonnU+ITjRwWi3+L/C8hpqEXifhxVahtRJtbvhQLJ9C4Yh3Fa4Q2WWIckSP3uUgc8vlt0GX8dyG9snwxzyhHIN2zxmbvgtkUSfBcQUV7JZj2i96VoicZv3R7WkjvtPEVF0T3BKWYPH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pyKGstONSSIZ7o5hTvaLgBHLfkZFGfI27IGZ+mAD1E=;
 b=DiJ2vGhp7dEoRJhCAghFhXAb65wFvGgueIODRlMC5KR1KTzW88NgSTCnJkmFk4sbLfjsCpkIIJhKBoy7Jhd3/XF1iCLoq2mbE7A84fEyfxSG2/ugh9UgnzfFUCYVk+f7MfnQH066ZZmEsaWVoMvv4Z5xuHvDmGo1QyOBHNyfEhvT1+bQ95TzwfPHBQNb7OdFc91n0BB/XFq8MGesmqjDLIwi14whcRKePhd/JJTV1pg2PmxoxR65pR5jM4GPTSWkXmuQClGmIjHmiNUkrGsp+m4TLv8CP+b4xJGy6Mfl79lfjVkN5Ehfukr7sl4Spvy3ojylHc2xkR9HC0QuK9vLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pyKGstONSSIZ7o5hTvaLgBHLfkZFGfI27IGZ+mAD1E=;
 b=tcJCJOnKxFpDarK037kwk8qlBDEY0W1zTVssH7rit3+vapbk+IrqKwRg2fRgzsMJXxk9SIspm7oYkIxzsscNEuKbgZAhP2GEi/QTiSchl5wZ+s3EzT40Lnxbg+EK9TyVMSqQbUCffAFZoEjzQjoy9TJT1aL7ZBs7Tjm0SCEeifc=
Authentication-Results-Original: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PR2PR08MB4698.eurprd08.prod.outlook.com (2603:10a6:101:19::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Thu, 19 Nov
 2020 10:40:01 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ad91:8ade:4623:e17b]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ad91:8ade:4623:e17b%6]) with mapi id 15.20.3541.028; Thu, 19 Nov 2020
 10:40:01 +0000
Date:   Thu, 19 Nov 2020 10:39:59 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-api@vger.kernel.org, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v3] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
Message-ID: <20201119103959.GB20578@arm.com>
References: <20201119052011.3307433-1-pcc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201119052011.3307433-1-pcc@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LO3P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::8) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by LO3P265CA0003.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:bb::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 10:40:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd6fc753-2ed9-46b9-02a6-08d88c777d66
X-MS-TrafficTypeDiagnostic: PR2PR08MB4698:|AM4PR0802MB2356:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0802MB23569C0C1A891C83B1AFE607EDE00@AM4PR0802MB2356.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: m578F5rkF4e43tGhHD96sMTGq2Z6rIMfgLJcyoTTHq7UccmZPwSvRk+CyDIa7GWIo6xKHSbS13XcSki1j6XtCPrL11pe4eKfVmrv173DhVQWUJRj8UzruB0bXSdA5GtFKysXQgyERL0ozGaohvXcJli4xpyNZb0T6RD3nsPQ9yX9FGCoaLtBtF/aiUvffR123Ym3gRkG7F2qSDLt7vhMbb/UY4zYX4hwwd+VSglDDp8N4srNd8XAllQPIAeu5ClCz+3YbWljcrB87ewGBHgu0V+gsuuhBdHdALX4FOCkfLp8GIvQ3ZdKIa0n+BCjZnFqhDejnnZOxAFB31kwdTPWt8v7bxElCDMF6DkyDP3CAqLaWxrt4sr5RYLVjxqiBozIECO8RmPvq6UXcemhCpS1Tw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(16526019)(1076003)(316002)(66946007)(186003)(33656002)(8886007)(55016002)(2906002)(54906003)(956004)(26005)(66556008)(2616005)(8936002)(66476007)(44832011)(86362001)(7696005)(52116002)(8676002)(966005)(36756003)(6916009)(5660300002)(4326008)(83380400001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HrFLLuO2kx6UOVS17IynbWBgFk2AguGwkN+XWsMt3RJKSYUALOMxg2mivCVsgdLmEydztB3agrwcaMS4x4GDWCfJHyF10rlws+ArQBuj+CCMNLC7EgqlBz4BnqrvJ+wbIDiUh9AZ0s1WkBfC2ee19AD6J/vHte1UaRtE/BZTQoRZXpV8O2UMFPhxt5fBxce4O+umIhD8zU3iZaxiJt9jTNm1BKAwlWbgXEGmGn8eFAq0H69h7LRYujIG4iKcX75fgvscopFS5Eivzl/26sJdi4O6FWwlGeNYEDS7LOe+rEORDRBvlKeN+iHF0SZqpkYGoYLHyzacLU6EXeCLjDuLbMwaQumV4xcZ73l64/EuE74rAsjFXu8nRUnV0zYdN7t50WSipoStWM0akOkFgUdeZ4odnfS1aSPHZm9R0k7epBh+zI3bRIW8iPE7/NpR4enGED+CBFhHev5guotrBAB3zInmVGNbGugle3joSBAry9ephRMefATgdwidE4FYpUlCjy4njT+hcrtpWv9VyL3fT6g8qAKDt9RC6FqhrgIBypwF8usawZxPzd7HgcQ6Y87cPgxM8J1PFI6WczEYE6+Jjjhc+YYWsaMeHs5nR07+DUeCh7gFz6DaMZ30JLgRkbnGrNGIg5sQuPrHuSirhjBjM3ExcpqWb7pw6k8LVUCGNn47jZRCetHlxEr1BLW785Md3n+886vZoJ0S69z4JRBZWXQJ9Uav1lcp3NoXRgMPEzTP1OJXHlU/D1pCS6BUddJ+77YgR9QzW0J0K+OtUA7AqDx6ayRWbaEr3NTVIYoylyy7h5YZHsQ7St/jjc3DB03JEaz75c5VmHQsaxcg0oNmA/0sYCBIrv8/g/2DOEQGSLrcJTocYqEdBhT/RsJ2h0xkzq7zQNZSjvI9RrjdrHeQng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4698
Original-Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3ac7278c-c709-4d7b-a83b-08d88c7777bd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+fwqlyS0QqJUHwV+yOCNq5r7smmUG6uEFpE+4CeYKoMaC39mf6Sv4UfszgpCX6S1WJSKOWL3e/KVvZJmdunf0FWVU1sQ+Royiwem9+V09shPgrNZ8nJsLI9bxl02Ediz44pJQPnxi0FQlHHcO7f3uHre2I/Il6M+Tvfs3lB5MXHxg1KGRIR3W1Sy2iNcidBTP0Q16y+73Y7qTmG9baSK51+Yrx/UwGaGNxYIzBif/YWqSAOCeJt4cyv9e3mF6EfqpAv2Gi0WJ2L8EBTX3bMNeAgIomdxxwnjlr+UGJUu/tagSMjuihHNz79VJhp/nRgif2EFXv4xbLTz8ljNDa09LvVYC9TJ2kANtEbhMnUkHcQRgy+q7TaSlgsOCVFKyvrAinnaYMxmnnG882mH4+brhWTwXuxoa62gHpMM0mQZJg+EE5mfU0USs5qD+1S2mE08yutbyHI5j7KZ+UqtiViCZSaSVVJdiEfrEO/hhh7CGA=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966005)(70206006)(8886007)(6862004)(2906002)(5660300002)(55016002)(4326008)(336012)(33656002)(478600001)(47076004)(8676002)(16526019)(186003)(44832011)(70586007)(86362001)(1076003)(7696005)(26005)(956004)(8936002)(316002)(966005)(2616005)(82740400003)(54906003)(36756003)(83380400001)(81166007)(356005)(82310400003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 10:40:10.4050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6fc753-2ed9-46b9-02a6-08d88c777d66
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2356
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 11/18/2020 21:20, Peter Collingbourne via Libc-alpha wrote:
> This prctl allows the user program to control which PAC keys are enabled
> in a particular task. The main reason why this is useful is to enable a
> userspace ABI that uses PAC to sign and authenticate function pointers
> and other pointers exposed outside of the function, while still allowing
> binaries conforming to the ABI to interoperate with legacy binaries that
> do not sign or authenticate pointers.
> 
> The idea is that a dynamic loader or early startup code would issue
> this prctl very early after establishing that a process may load legacy
> binaries, but before executing any PAC instructions.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/Ibc41a5e6a76b275efbaa126b31119dc197b927a5

i would mention in the commit that the overhead of the kernel entry
code change was measured to be small.

> ---
> v3:
> - fix some style nits
> - move kernel entry ISB to after setting EnIA
> - rename sctlr -> sctlr_user
> - remove init_sctlr
> 
> v2:
> - added prctl(PR_PAC_GET_ENABLED_KEYS)
> - added ptrace APIs for getting and setting the set of enabled
>   keys
> - optimized the instruction sequence for kernel entry/exit
> - rebased on top of MTE series
...
> +Enabling and disabling keys
> +---------------------------
> +
> +The prctl PR_PAC_SET_ENABLED_KEYS allows the user program to control which
> +PAC keys are enabled in a particular task. It takes two arguments, the
> +first being a bitmask of PR_PAC_APIAKEY, PR_PAC_APIBKEY, PR_PAC_APDAKEY
> +and PR_PAC_APDBKEY specifying which keys shall be affected by this prctl,
> +and the second being a bitmask of the same bits specifying whether the key
> +should be enabled or disabled. For example::
> +
> +  prctl(PR_PAC_SET_ENABLED_KEYS,
> +        PR_PAC_APIAKEY | PR_PAC_APIBKEY | PR_PAC_APDAKEY | PR_PAC_APDBKEY,
> +        PR_PAC_APIBKEY, 0, 0);
> +
> +disables all keys except the IB key.
> +
> +The main reason why this is useful is to enable a userspace ABI that uses PAC
> +instructions to sign and authenticate function pointers and other pointers
> +exposed outside of the function, while still allowing binaries conforming to
> +the ABI to interoperate with legacy binaries that do not sign or authenticate
> +pointers.
> +
> +The idea is that a dynamic loader or early startup code would issue this
> +prctl very early after establishing that a process may load legacy binaries,
> +but before executing any PAC instructions.

please document how the setting is inherited across clone, fork, exec
and the setting at process startup (since it wont be inherited across
exec and not every reader knows what setting is required for bw compat).

thanks.
