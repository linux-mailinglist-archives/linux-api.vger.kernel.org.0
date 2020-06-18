Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE39D1FF182
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2020 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgFRMWc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jun 2020 08:22:32 -0400
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:37861
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbgFRMWa (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 18 Jun 2020 08:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx+H/sjnx+jw5F9RpBK8nCF3GbXhk4N3u2Nz85dSeFI=;
 b=AGqycqifLCjqYZp3RDIyyD8tb1RCh5p3OTqZ8fcKB1Qx2ZV7MtKn2nfY3tKX8Ok1tuYkTt2Jim0W9GbQAVWw/NQjXT831iodpgIVYffrHhzy6NXaZX+Q0epMsxR6Dbw1fTaMijkzJG2H0y4P4G9/Ugnw0OKwIj+qImFRqJemETs=
Received: from DB6PR07CA0017.eurprd07.prod.outlook.com (2603:10a6:6:2d::27) by
 VE1PR08MB5214.eurprd08.prod.outlook.com (2603:10a6:803:111::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 18 Jun
 2020 12:22:24 +0000
Received: from DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2d:cafe::9) by DB6PR07CA0017.outlook.office365.com
 (2603:10a6:6:2d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.10 via Frontend
 Transport; Thu, 18 Jun 2020 12:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT034.mail.protection.outlook.com (10.152.20.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 12:22:24 +0000
Received: ("Tessian outbound 866352848bb9:v59"); Thu, 18 Jun 2020 12:22:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6d8593013762e825
X-CR-MTA-TID: 64aa7808
Received: from d72f297bc5ca.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0A7A8AE5-FCF7-42E5-A68D-13C142C72FFA.1;
        Thu, 18 Jun 2020 12:22:18 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d72f297bc5ca.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 18 Jun 2020 12:22:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLvHsquksgaHRtz4xh3p3a9DXcvOJYekiM1+xWAEsHqX1k1GkQTfRDpUFZGWPt2TFX5aCYY8OcAsmK3x95i6l3ubZkKiUCp2os0BL4ti0mU/IkBD1LtDx/2Qs1j7zCOhCkTQCbQK28ykVgqIl00JwoUSysly7IWTFylxKKQAQ3Hlx9WRQRHHLYjoKS2kpysRum0/+JZrAeJtqjx83KdddZ3sQuR857xIcR1r1/RsGx263WfrtRUE9+wAmPfW67rjLNcFH1XKfyeugntZ+pvpsCPBhz4CzwqMgdnzE9VJzEckvLqQtbJj1y3CHRb++IQmX0ye0ZpTbmrXqer+VU39fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx+H/sjnx+jw5F9RpBK8nCF3GbXhk4N3u2Nz85dSeFI=;
 b=iOBhPjJCBQ0xZp4dCOGTLayJpR1YcVHyVGo0JeX5Sqn6C8mhRnfe5XEkemJFa34QQYJzg4i4QVjaIEkhJqWn8I6uT8Hzv5oXyzYGGLjhoa3oj9MmISoidTKxpwm2qzmShoZn84I4PIEbiahTNe/WEw2ZLMuH22F43Ii+4ddi0MQMxH1l1qYYWGwISUM3w6MIhy0TEkhgkonr9LS7dZnjb9yjgbVNiHBPMH03XTZFHf1mqsO2ATaBGtH98ou+NZD+t7MTfHyNQNy5t28XBgsHblnNTZ97H8bWv9oCS5vWdzuowCN7vLiMCEk3QR4uNAvB7XJ3DkMK25Xq1omg0wU5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx+H/sjnx+jw5F9RpBK8nCF3GbXhk4N3u2Nz85dSeFI=;
 b=AGqycqifLCjqYZp3RDIyyD8tb1RCh5p3OTqZ8fcKB1Qx2ZV7MtKn2nfY3tKX8Ok1tuYkTt2Jim0W9GbQAVWw/NQjXT831iodpgIVYffrHhzy6NXaZX+Q0epMsxR6Dbw1fTaMijkzJG2H0y4P4G9/Ugnw0OKwIj+qImFRqJemETs=
Authentication-Results-Original: codesourcery.com; dkim=none (message not
 signed) header.d=none;codesourcery.com; dmarc=none action=none
 header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB3781.eurprd08.prod.outlook.com (2603:10a6:20b:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 12:22:16 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c%6]) with mapi id 15.20.3088.029; Thu, 18 Jun 2020
 12:22:16 +0000
Date:   Thu, 18 Jun 2020 13:22:14 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ben Maurer <bmaurer@fb.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup
 and thread creation (v20)
Message-ID: <20200618122213.GQ4066@arm.com>
References: <20200527185130.5604-1-mathieu.desnoyers@efficios.com>
 <20200527185130.5604-2-mathieu.desnoyers@efficios.com>
 <87d06gxsla.fsf@oldenburg2.str.redhat.com>
 <alpine.DEB.2.21.2006031718070.7179@digraph.polyomino.org.uk>
 <188671972.53608.1591269056445.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.2006041745360.8237@digraph.polyomino.org.uk>
 <419546979.1229.1591897672174.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.2006112026090.18393@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2006112026090.18393@digraph.polyomino.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::24) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.53) by LO2P265CA0228.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 12:22:15 +0000
X-Originating-IP: [217.140.106.53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f3d16df-0b19-44c1-40e4-08d8138241bb
X-MS-TrafficTypeDiagnostic: AM6PR08MB3781:|VE1PR08MB5214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB52143093D9EB5688C26BCCD9ED9B0@VE1PR08MB5214.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rqVpgYxwdfUw3tq5cwaMvFO7oS+SwjRq2J+G+qGvy5opSOAtsIWQ4h22M5UxLEivCbg8Tx7NnCiVI80iHD7Arz9NdFUF0CeF7owxZgXIdDwOhBTQyZv4JTpbnvOoxezoNewQUgqdKQo6t+ASIbpIQcGFftA699y3+5MtUt3leLfGnSlUZYt7B4EmIXcXvxZ4NEw47PvHwc1/Szrs+nCIzIINHMLfBl7C1XqueMwR9GukKJdCtU/CbIHQt7VHCLQNZEsKfrLNrqaEVvXJAxjomOnOvpfEnZel3dRn9VX3SJYrJmzmPj3E5su1FgSi6nytbw43JtIbV9CZt1uLz5T97sVKRTzSHfywSYrdnsffvP3FLuKB4lVLm+JICUQbIhTpw8OOnQNdvuPXxAWdXoO0fA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(8886007)(33656002)(86362001)(6916009)(36756003)(7416002)(966005)(478600001)(54906003)(2906002)(186003)(26005)(2616005)(956004)(316002)(4326008)(7696005)(52116002)(83380400001)(1076003)(66946007)(44832011)(16526019)(66556008)(8676002)(66476007)(4744005)(8936002)(55016002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AfEXc1hJdpOIYFj+CKJwIVAZUQSMCnoMLWSiSsx3/mvZYAc4oi6GqCF/bEWnywP6J9dFElShz7817AVOKbUcDQ07p70YeNbjTY6vrrKiu57OFN0fy6LS0nZgTgzkmtRsdxW0zxO3i/XE3PCWZjN6lsoQpKRaQO82PrvEPrXky2s3B49xMfkYM9HM7nKjYkzASRJgJCo84laCtRJO+fInfgAE0mdLBSVPyjPWtCPcyE81UFhA8TCGq1QyPIEPEkcTlB44WhiklVYwLuzYy54/rtiubAC2ED1GZflWO2XaT2jajb9IX0ENsXYw6Gdn8sdBk1Zz5imCH6evYUblviuHAXygU1UGloIigH7jYaB0wchPqQA2TJV5StcfmWWtid/9pizkzRVzIg5wdAihx9GMK2DQXp10zhFPeb7XDvqrE91Gc9o3RpKx/vfDLWX2hvDzKlPbw60+6erOUv2Ck8MgZSIibkjiW7xZVGuGpGHYdD9Lg9ldQLLOdGe8YY7bdXXk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3781
Original-Authentication-Results: codesourcery.com; dkim=none (message not signed)
 header.d=none;codesourcery.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966005)(7696005)(81166007)(356005)(336012)(186003)(36756003)(966005)(26005)(956004)(44832011)(54906003)(2906002)(2616005)(82310400002)(316002)(8676002)(16526019)(107886003)(450100002)(8886007)(4326008)(1076003)(6862004)(5660300002)(82740400003)(8936002)(33656002)(70206006)(70586007)(47076004)(55016002)(83380400001)(478600001)(86362001)(4744005);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1701d1b3-49e0-4aa9-3206-08d813823cf2
X-Forefront-PRVS: 0438F90F17
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWL3twbKwZ5FdkePc4bapNKCjpjn6vmDWCPh3tBc0XiSxZFIm+Wixklvj4tXSZvd+hdaJCxlu7PzGOUk5BusoaYrnjZD3NfUTxw3IIrF7KCocQdzwI7h8C3yNlub/0HgGrGr+itfLKg+ZYJFye5UgBdYKRUYi2zEv2J4/O/O2pMgyLGa2qlpKHOWQiwho/6lTbGDEwKazV0zwBhSEOabuMQ/1mLsTzinXHadujLG3AqHa8xxbZuXtCHbg0IH7CH34aZ7tycx95hrdafNdo4ieVfzuXyQOZ5iw6wBMk5J6K47MMxsjZTxdTzR9sJdcehH6b3sbsnbT/MQqN3puB36uAU/AV0HZqK4p0VAbcj+A1uuWThbpg0cS1Ms5K011PdgcqYt6qxyzFNAeOdRiBAfiU8qnOraqszNSykaKkWfS8k4ZS4ntJUAfYmhpth+wAenRrZDKNkQdZ0eTXB8/XOwMQ6OFaq5lm8u4IJU1fh0Wu4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 12:22:24.2292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3d16df-0b19-44c1-40e4-08d8138241bb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5214
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 06/11/2020 20:26, Joseph Myers wrote:
> On Thu, 11 Jun 2020, Mathieu Desnoyers wrote:
> > I managed to get a repository up and running for librseq, and have integrated
> > the rseq.2 man page with comments from Michael Kerrisk here:
> > 
> > https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/doc/man/rseq.2
> > 
> > Is that a suitable URL ? Can we simply point to it from glibc's manual ?
> 
> Yes, that seems something reasonable to link to.

is there work to make the usage of rseq critical
sections portable? (e.g. transactional memory
critical section has syntax in gcc, but that
doesn't require straight line code with
begin/end/abort labels in a particular layout.)

the macros and inline asm in rseq-*.h are not
too nice, but if they can completely hide the
non-portable bits then i guess that works.
