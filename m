Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAE12B6D90
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 19:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgKQSj3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 13:39:29 -0500
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:29013
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbgKQSj3 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 17 Nov 2020 13:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A2fpYSdelGO11dQFR901DaaLdRksdEr0XXrkqfOmu0=;
 b=iR5097JIfAgJSH/GXfTnyvpjC3sz4vrZzYL6ogveP0uh/JPQRL08fL+KBjrmE4/KQlxZL/lR15HvasEYCjDvkOXzbYKmTY4HUaEgw2hkOdvwSEhVXbPRkekqZ8/O8sYCfaCEgXWxSfikaooInhn3VUjcYJNlAbpJA9oPjfOPv1w=
Received: from MR2P264CA0064.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:31::28)
 by DB8PR08MB5449.eurprd08.prod.outlook.com (2603:10a6:10:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 18:39:25 +0000
Received: from VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:31:cafe::70) by MR2P264CA0064.outlook.office365.com
 (2603:10a6:500:31::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Tue, 17 Nov 2020 18:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 63.35.35.123) smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature
 was verified) header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror
 action=none header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT061.mail.protection.outlook.com (10.152.19.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.22 via Frontend Transport; Tue, 17 Nov 2020 18:39:23 +0000
Received: ("Tessian outbound 13ed5f5344c0:v71"); Tue, 17 Nov 2020 18:39:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 94b8eaf14500724d
X-CR-MTA-TID: 64aa7808
Received: from 55c29a3d5c6a.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8533749F-9FD7-47FF-BAA5-AFCA13D96A71.1;
        Tue, 17 Nov 2020 18:39:17 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 55c29a3d5c6a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 17 Nov 2020 18:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOLYXz2EsC09bXtNWC+rQMno8cGNE3/cUPEHPs2SIYbaJjFTKy1ZWer8cpy7ldkOYKPYqysJUcblgIW9i8NsGsw6M3RFcUz/kL7T1gy917k8mjXPVx/lvaayQ3XjQ/zR80EEdHukI+tCHsWs3Dt/XLjfWJxynLNHIcb9KkPQah+MtoRrGDRIN8at+AgK9IWWJkG1A+6ijKaiOl20Q3Ap0kxAZDGYAmXTSLKLjJznoiOAl6WeiHdt0EzeCtb+Pp3ZDEu7WrF37zli3inpbfvsNsTplWFKyyw/R0Gmhh+i87yMJ/LaUSh2z08fIWdoztp8WHZQybDwNs3IHeYjJ149Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A2fpYSdelGO11dQFR901DaaLdRksdEr0XXrkqfOmu0=;
 b=f+0yBmNBKYKSpeCahO+d+JJtRjQl1qB5VdUo9UNLkrdPaNMGl2NsD63c02GbFLX621H58+qp8pVlVboK/NC0f1E0t4SOyr8H2+OJLWOHZBVmDtzVkNTJ/5yPgJkac0XSX7anfBqBJHj1szMgB7VoIdKNqaZaubGxCXcCYvowpA2VGR0ckvI5OcYiRg1ewF3BMbssLcSnLxWm2oGmr+sXZZi8VB/bVTymGqNvQnqX7Zd8Zj9Duw2fKFqe1adzs7eMn54pw/4l07CzzpMEwD1WwK0mrPUGrS5SX/Q5jXWL4MWaJOewW8uI4DAq54hBzwerjMe5in/4DWJAs54Aqr8AFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A2fpYSdelGO11dQFR901DaaLdRksdEr0XXrkqfOmu0=;
 b=iR5097JIfAgJSH/GXfTnyvpjC3sz4vrZzYL6ogveP0uh/JPQRL08fL+KBjrmE4/KQlxZL/lR15HvasEYCjDvkOXzbYKmTY4HUaEgw2hkOdvwSEhVXbPRkekqZ8/O8sYCfaCEgXWxSfikaooInhn3VUjcYJNlAbpJA9oPjfOPv1w=
Authentication-Results-Original: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PA4PR08MB6077.eurprd08.prod.outlook.com (2603:10a6:102:e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 18:39:15 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ad91:8ade:4623:e17b]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ad91:8ade:4623:e17b%6]) with mapi id 15.20.3541.028; Tue, 17 Nov 2020
 18:39:15 +0000
Date:   Tue, 17 Nov 2020 18:39:13 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>, libc-alpha@sourceware.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
Message-ID: <20201117183911.GI15033@arm.com>
References: <20201014055106.25164-1-pcc@google.com>
 <87blfv6fj3.fsf@mid.deneb.enyo.de>
 <CAMn1gO7a-uyP93P4KapbsXy1+HRSuJR4r_kyy0_-FCY69qO_nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMn1gO7a-uyP93P4KapbsXy1+HRSuJR4r_kyy0_-FCY69qO_nA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LO2P265CA0404.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::32) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by LO2P265CA0404.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Tue, 17 Nov 2020 18:39:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f974ced-0cbc-4e40-fe37-08d88b281ab8
X-MS-TrafficTypeDiagnostic: PA4PR08MB6077:|DB8PR08MB5449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5449B5421C98A46C5B7DC7FEEDE20@DB8PR08MB5449.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: UUToNJOBqjXvg8AgPfE2i5qDvS71QgQtNx9MrgW9Rq+pQclO2ffjvablf5YfgjHQtKOmytFzP3xPXr8Dy+FZNrIQdGgZsj+Eq4CFkvyw/24k/q3gWN4XJfYIR/afS+QOhGW2AQCoa3L6KjzChEMV/ALJu8vS47giTpFbDkDu/VB8ZTeJLTYIWJH5VGwUkbimXvVkzTlC2ZnViCPnAGNx4Uq0NylXpi5vJyxJ5bETyzo96pDgV4nRKur5ZFuyvlLygo780iyZhjx4k5udJdMm+asYpca/byjFnUJcUfMwa3Z5j0GUPWtwYYCoFRjB5r2TLnY8abp2AWqNjBD0GBf3eRGFECbJEDjuH2615BVoRnZqr3NlUXvUHFum+KV35PTr5/AirupmHuQf+DwITYIWLA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8936002)(6916009)(956004)(53546011)(2906002)(2616005)(4326008)(186003)(7696005)(66556008)(66946007)(66476007)(8676002)(83380400001)(16526019)(52116002)(54906003)(44832011)(55016002)(33656002)(1076003)(26005)(316002)(5660300002)(8886007)(36756003)(86362001)(478600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: F8EsfmtXe9v8qgHiar4LXjkuCqNJQ8EEYTrd+KBAucqROIQ+0qSEGPDlS4jXSm8IzAwB/7XPXC8xU7kvilnBjhnOVp+OEYJsvzzkIsXUnP5ceNrY7NW/qgaNfPz0jMixMheXVYpUAxq9dHQOmb+6QVgchOVqI4x0qm/MO5Vf0QaLWAJoCaCAy6ss2rjUQQUhPuvFJVy4TOao3S8n9fNEYDaGDSQURPMs1lvodetPhCYjCTh0mEXGzbw0sv8VR0LU72KQjq6P7M3kjVPlps4yxOKxaaQTy9OfNPO/jJEeahpuNqiBShBF6vwBxcElWzRTA2U57Bye6q9pqTG67s7E//zzKHZHk/4g1bC0c64MVlQ56bFEu5DzDwOW+tyG3RQ4nSh7k5fEg6VSYN+Rs9rgJTxUZy3nxDk7F/3nh9H7PnYA4a3U/QU8TZ453rUCAlN7//wt5MkUMvJI//0+DRsVAGgegzVEwsa1BV32PHnrcFYM2+6VAVbmCrcFP+16gs3xFDvt07Iy3w2CBho2nkuLk0Gj/+KmGiOzwjE4P6ub9qCtXP7ULwpNJ4JV+HhQbebYh8xqpQeTuoq0qk/gVoSGsmKvAPQgPXBrUIZK20tCtR3z10a7P4JG/HBEJ/jQUXrzUIB14x0WblDPU3ON52+irkaQRjerpIu/U/oWHbOlWJrT1O/j9r01nuIFVev7kIOLFRy1G646kvK09ZTMa69pDEVVUw8YFYr+ki4/DBHG/K9EMyyKvbLG1H6WnAeFySRvGJszE5r4sC2Ri3KuiFH876+zkMEdIkvqolAeeh/jQpq88RimSowBLyjhyz1kDfLS70ZosatGZxOmSlpwkljfWmzZE6+l3QTZu/L4pwnnOCtT6u0YpIf1uPDP/KmxNMOxfrtbHN9ZdRGi0tpFGNhjDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6077
Original-Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: cbee72ef-3992-419e-cd52-08d88b2815cf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMxRO5u+m07jjhwtije0/adIRazg2t4KuXWhaYHTce4n26PAdzRdeFH4AHKpr8+lQbxxXPV27TUWhSXXfAjz7tuBus4JexlM5IaALBGArgECIT3NAEXGxnzPuHSkP3Btud4HMwKtnN+tuqm0GFe4iw6PX/bc78jCtozsZfVEnpYrxS+Ra7SPbPTC+A5Sx/E7A7PaGmv8QoF498lJMSpAXARwHEmh2zmo5BpxuGDGypWlsZoYsTeztVqvN01AP/WYsBgf8RJa8SI2ahELG+pE+fFwJOA/8Ht073UVaO65kZ8MSNkCSxuWmo1lamgkkD2ZnRaFpyjOdJIUhMgiGjB5KhA5OAXJmzghq17lE9PExkBdKKCxlV2N5DyLkZCv6wln6dWgP8EGdy67K5OJaeBB4jlyBMhl7cmTzv8jf510HfsGQXKcw2AdtJbRatDOAhnIMjL7BvFFWXctsmj5aGQbf4y32qYhRAWfRZqDt5TgaCA=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(376002)(346002)(46966005)(63370400001)(956004)(2616005)(4326008)(44832011)(316002)(356005)(36906005)(8676002)(107886003)(5660300002)(8936002)(82740400003)(33656002)(81166007)(54906003)(6862004)(2906002)(47076004)(70206006)(55016002)(478600001)(1076003)(82310400003)(70586007)(83380400001)(336012)(36756003)(16526019)(8886007)(26005)(186003)(966005)(86362001)(63350400001)(7696005)(53546011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 18:39:23.4939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f974ced-0cbc-4e40-fe37-08d88b281ab8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5449
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 11/17/2020 10:17, Peter Collingbourne via Libc-alpha wrote:
> On Tue, Nov 17, 2020 at 9:48 AM Florian Weimer <fw@deneb.enyo.de> wrote:
> >
> > * Peter Collingbourne:
> >
> > > This prctl allows the user program to control which PAC keys are enabled
> > > in a particular task. The main reason why this is useful is to enable a
> > > userspace ABI that uses PAC to sign and authenticate function pointers
> > > and other pointers exposed outside of the function, while still allowing
> > > binaries conforming to the ABI to interoperate with legacy binaries that
> > > do not sign or authenticate pointers.
> > >
> > > The idea is that a dynamic loader or early startup code would issue
> > > this prctl very early after establishing that a process may load legacy
> > > binaries, but before executing any PAC instructions.
> >
> > I thought that the silicon did not support this?
> 
> See e.g. the documentation for SCTLR_EL1.EnIA [1] for details. There
> are also enable bits for the other three keys.

i think it was insufficiently clear in the architecture
spec how that can be context switched. (but it probably
changed)

> If you can avoid creating function pointers before the loader has
> finished recursively scanning all libraries, and the ABI uses
> different keys for function pointers and return addresses, you may be
> able to get away with making the decision in the loader. The idea is

glibc currently only supports pac-ret, so if we enable
or disable pac keys it would be for pac-ret.

(i.e. we would need to do the enable/disable logic in
the dynamic linker entry code before c code is executed)

> that you would disable the function pointer key and leave the return
> address key enabled. This would also have the advantage of at least
> providing return address protection for some libraries if function
> pointer protection can't be enabled.
> 
> > There is also an issue with LD_AUDIT, where we run user-supplied code
> > (which might be PAC-compatible) before loading code that is not.  I
> > guess we could disable PAC by default in LD_AUDIT mode (which is
> > unusual, no relation to the kernel audit subsystem).
> 
> Yes, LD_AUDIT may be difficult to deal with if it can influence which
> libraries are loaded at startup. I agree that LD_AUDIT should disable
> PAC by default.
> 
> Peter
> 
> [1] https://developer.arm.com/docs/ddi0601/d/aarch64-system-registers/sctlr_el1#EnIA_31
