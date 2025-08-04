Return-Path: <linux-api+bounces-4289-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24D1B1A342
	for <lists+linux-api@lfdr.de>; Mon,  4 Aug 2025 15:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6B73A6F09
	for <lists+linux-api@lfdr.de>; Mon,  4 Aug 2025 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB348213237;
	Mon,  4 Aug 2025 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IA6DKP6X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zlf7erzE"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180345029;
	Mon,  4 Aug 2025 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314317; cv=fail; b=T0e6bdrIbQGiJFXTpINaJ268pfJTeJJj1b9voo7TxF6SkzPopyzMXhAMR6Hi3TZFzdhIKhIWzrPTgunwmhfAH5IJI+NuqyuZw2q400xJ55Qn75ohQ4wcxITw/Xc/7t0BXH0L8gYq1WyhU7OLjJAeXVVjoWUZnplqsoCF45biyh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314317; c=relaxed/simple;
	bh=z7L12GtimNCUmMM6gZE6yD36ZTVVq4EipAxqzIrB/cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CzGveU+pFlwzOUiT9MGhuH+836Uk4Frfh5rqV0pxXYcZ1iTxkl4wyy3gUDIZUxvzIGaLKQqXXpWMQYQ2Zm6atPSsKGBDBeuVUry3YC04U4BBr2IJRrrwWLvJ3U/4wlnPyN8naG38lPJZcc4mhvp6cvWjaYR+G6gy9U1/+YSYGko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IA6DKP6X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zlf7erzE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6fsg021638;
	Mon, 4 Aug 2025 13:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FEnYQMvHXQIO87ASjB
	eiagXlFo3zF/tu6JPe32N8qgo=; b=IA6DKP6XfNZtymztqLOYOUBwkcnnF/PIIj
	06FMtDUWTKPZciw3XG/f1re4bmfgjT4T1fT8ugUn6eSBPIaxxKutTl2+zOBhdV9i
	gB4zBes26bQTZsmIMWDzKhNrOj16d5NMV9kEwPRe3Ewfq9MleiId1HhV2qHbBXBX
	WyYv6YjeLBy5ZgugWIcfdKUa2Pqbize1Czkbe2gPNsIRMfu4SsmGp0mXvBnanEGv
	BQ5IIlUzCHdTMLDaUE7b1SXuRt2mS1avBQaZs5MZ0nOkVJqEoe4I9ZPkZqhrcqtR
	GAlXl/oJvEyTYej9xy+n0mTY9p4oqSnmUR4tTDaGGO02nY+INnPQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4899kfapa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 13:31:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 574Cu4Jb031976;
	Mon, 4 Aug 2025 13:31:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48a7jum30p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 13:31:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVdDEMfkS7ByA6XxXoktx1al0MCo+5l/s/MH/AH2QjcuRMh9mI0jW0EZmASyOdabmkWftdkCfybEPyAZB+EsWaDnJH0XtEsSN81/jdd1kYs5CJd/1gCG16KUt992g6v/f7e3q69GrtfDoVU+fUhWwPdyx0xZ4XzBZ+4w1n84dg/IrjRikPvJryt48eiRnbwNnUperuIyT7lG+EiencSMIL9cPXPzqnDQoa75AMWNZchFo1wq9GGzBPbVD7FBSoNhk5WH9KGT8alrDKUaiNWEKuwzJ3uRA6GuUyp3bhNpOG/mQnyZik+6ARqeHMhMyIiNybudHqfOfjGAyiabINC3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEnYQMvHXQIO87ASjBeiagXlFo3zF/tu6JPe32N8qgo=;
 b=f6C6njy/dYuiqrMLk0rtofinV23plmwK/jYmEomdTtdh4afJauS3O5DQqNWudViYoGoadWCXNBASV7YXgVDogboBl/qxfUKARrB7F3RohjGQXdtqdovUmlbEQVvg45TK8tYfbkAMzUaw2bB1FIb0ZbTNwvLrSfPZvOGo0MZqeieeAdWkJfDdDX/W1kKrKAaw43UQya8cIKm4FkOEW642zYFH2iJ9sL0qcu+MbYScxSRj/R4fsygaesaG2jov/RQYViobYZyjbwHCRC+NVZ++2uum6s8SGGfx7V28HNtVXMuOai3xaO16boLhNYwShz943iNpvd5liCr51dk3k7Urlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEnYQMvHXQIO87ASjBeiagXlFo3zF/tu6JPe32N8qgo=;
 b=zlf7erzEnGKWwdsZnf93IJktxjF6OceSfluEZwYNHfuhezrGNjFmKVTzLHmx7GURaD+WvAfH0a4UXP+2LPWQfKfnG3mZpH1wW7gSPFudwQ4z8PUrTq967E3CmKtEA45ayTnKeV2xLGbQpz6XllUWqs8fe9VrX7ZMQLl9FgRbnZ0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6742.namprd10.prod.outlook.com (2603:10b6:8:10e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 13:31:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 13:31:05 +0000
Date: Mon, 4 Aug 2025 14:31:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v3 1/2] man/man2/mremap.2: describe multiple mapping move
Message-ID: <67d11254-67d4-401e-ac8c-a8d50e43f087@lucifer.local>
References: <cover.1753795807.git.lorenzo.stoakes@oracle.com>
 <1fd0223a6f903ffdd8ba644d0b67820b1921671f.1753795807.git.lorenzo.stoakes@oracle.com>
 <ngytuoex4uvu5epsdqhvhypnhqidkr7cpwmmcxrml6kpftgusb@jo5ql6eko2ir>
 <0e3d0dd8-994f-4665-969c-6daf332c5b94@lucifer.local>
 <dizfk5jqwwzozotvkk6phb36blcpsve3yw53xrdjwqeut27djt@rftbd7lkgsjp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dizfk5jqwwzozotvkk6phb36blcpsve3yw53xrdjwqeut27djt@rftbd7lkgsjp>
X-ClientProxiedBy: MM0P280CA0078.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9b4ec1-5cf5-42a7-066d-08ddd35b29d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oqe9G7x8tl3TczeDsYlVhowJpD81N9JWkyojUMYINZIYfeDJiBvhrQYKXoa6?=
 =?us-ascii?Q?mOWV3H91qjuXBmpwZGskOAvRG7yh0Ra5CA2scOZmIR9aKVrR3id8ix4sajXM?=
 =?us-ascii?Q?paHcJMPQmeelc9d//QTdYdy1WITOVk+6kHKaRNqPA+IB2ghk6viWagIORkP5?=
 =?us-ascii?Q?Co1P7LtDXR0K2BJWUV8trJ4i4NIexgfpKziuv9D3LV2v0r829N85B7tmEnK2?=
 =?us-ascii?Q?b0glzjK7Fiqq9dINY8HbprPKDsdfE7c5ptlTq0LdrfrOKGsTsGH4oQ+bW7NH?=
 =?us-ascii?Q?TtQpJc37Il4CzgQdrZEaKS1Vii9gRHSo6wUYqSXcSqm/7j8SrQr1AssBnivl?=
 =?us-ascii?Q?ge+sYOXwIqeNnCLkqrRJoKkjsoEmFawiVGctEGBF0YmzuUoaXbmlwMBf6htm?=
 =?us-ascii?Q?OL7yIx7I+JeqT0i10+kZkAL0O4uy9koPi60TU8cJJ1It4NC1ZOpS2k8btxPo?=
 =?us-ascii?Q?2ac6qLhldgyszGUlzvcoSciUsjU56JzkWKdk17RQStN22NK2bLjayrkNd+jC?=
 =?us-ascii?Q?HPiNCbKqozmDA8ZwdsqUcz0a8LlQnUf4ToTKLEDYx63cPtV9E1HYky3QRAEY?=
 =?us-ascii?Q?eob5oimPCk3CXFFzfXb8+8A8VcHk83es3b1ElZKtEq3tQrn8nzjxLK7mv66O?=
 =?us-ascii?Q?CB7DjgCaH8MhzrP1QxYFrMWDrDff96oiqBa01kz1+Ln5kW2+rBqwFyWje1I8?=
 =?us-ascii?Q?EIyYp4hUWOcX71Fp2c3rN7aQ+/wY2S9mkHseGuVSHXC2Kb+zJW2p2dMgXnpX?=
 =?us-ascii?Q?VbP7MHd5JQD8RICWjrobrmPnk0c7xxDSt+T8NW2cL+rNwEyNK4rVd5j0NDoe?=
 =?us-ascii?Q?mjrPGmyItKapqdo1ySeItaEJg8JpIcZBQHNyi3JH1nwwvpW218r4gpiW7MZZ?=
 =?us-ascii?Q?rFHLGkGrlUnJX6lr4xJXIgMVDdOAIw38MTBPWPWlIVuy3UsA0g1RGL1FdKHA?=
 =?us-ascii?Q?h7Nmw0+GI65Vc9Y6R6RcTO+jdv3yA09s61pSp5MT2Xf2KWk2+saLTqem9pTI?=
 =?us-ascii?Q?lFareT/6BgKjpkPflO2m8CFR7cUMjZ03FrX+aGjhoc0BFOHuTSGeA/nYIyQ7?=
 =?us-ascii?Q?YEMA5Z9A8vRFPVVaSh66Nhj3fa7JuGANzW2vu5KgtLUOz4tFdaMyF6zqrDH/?=
 =?us-ascii?Q?KOH3iuyYUlRFuIxRqsO28MeuNdWntmfDqEWTD/R1RehwOkr2hRgJf/qtgSVj?=
 =?us-ascii?Q?2aFlBuThFVuQQel+NymWdfKzwYgLXN1X1s0RfPD5w1NWlXAN48u1IcB+ZiyL?=
 =?us-ascii?Q?vET9VCA9D9RzVRwUaNOShYME41qm9gPKO+sZWWDb+hpV28oC5kZprBdUw9Po?=
 =?us-ascii?Q?qevq7F2PGw6KZjESnMvbNxielBMs870UN/ZTluCfVZWRiOgNlDLA5IcJ6ygw?=
 =?us-ascii?Q?jjSqM1s86bcyAyDxn5lEwMR0wWJsMJ9E6nyUG+4ZKjWGPQ3Q8pTZgMLYZlo+?=
 =?us-ascii?Q?r+9SCXm1HP8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7YJA7PbcH1CAl5M+hJI7+H3FppbU+guM3hZkgNNS5feKihgXSK4PnNmDVsWc?=
 =?us-ascii?Q?Okl7VVqsAZSYa9NdRAh3GDilk9clDannwn5PDZFQq5y4g43kSXk4QQdoi0A2?=
 =?us-ascii?Q?SJ9BWuO64QvzacrNDpQvq7x1PAQji+UK/TMUslKx5FDmucntjPW/YwNW4mIh?=
 =?us-ascii?Q?x+pWjULgWDm326VPl1T1v3WzM0gf7Tlqb8a9B3Wkvqy622iwC0m6Jx9aOsJA?=
 =?us-ascii?Q?582D+lO26XE4H7BykwPaD4hJPPc9xtA9E0HOIUcJzZUd6Go6WRzLz3Vm+d4z?=
 =?us-ascii?Q?caiA6RQGIW0b2YECLxpTl3ltyDhvWLLr4JzBtT/OQp7HyCc1weAFGJsr4QZF?=
 =?us-ascii?Q?FN2Y1D/34kVmAb3zPrUNhFR7syZmrnEOBMLcwuDtClifk9LXYFiZCau84V9V?=
 =?us-ascii?Q?yaD+yCJ50FUKT1sKTrqqW8jCjVqAwDHJlQtcd8XCnk6MT0g2kicWY+fa8/qC?=
 =?us-ascii?Q?+QvumgRfLjdgWb8N5vPHKLswjgpu5hINP/cbye32tyS/medJ8QbyohKSjlvB?=
 =?us-ascii?Q?iM2yrJ7+7WzQUE7DdyxFxTAQW/kyZREr/AG9O1pPMu4fIozibAklzIqj2v3e?=
 =?us-ascii?Q?J20lHQu9Wq0ncD9UjM8U6zOwW4bglLLt4vY4GEqHXFZAuy5CcvIBWgjlJkQR?=
 =?us-ascii?Q?0AUttFdLF7pZ1bC6V+tpLB1vmHOKe4F/WnEwvq57HTR+iGVEaYmNso0rqSyp?=
 =?us-ascii?Q?+9ZQlshrv8kOgkvawb+kpfvVcQefSh9O0Y2P0XDGEsrmPhKc//S4fi3oERTr?=
 =?us-ascii?Q?7biQNakL9RZmyCP4MD1pQ/oXREz1Ur6V/FioNbADLSWs+X5Q/FQFXXrWqn+o?=
 =?us-ascii?Q?kY+e6ooyfqxzQ7FdegHYa6S/daRppXIeZwA3kl8wy7K+TJHDMLEfQpYo/FYJ?=
 =?us-ascii?Q?bDw5UhIeXtym0wEtqc6xLOCRYXqpL9mJ0mtzib8dO6G2cHabRlRwDjMEW2O4?=
 =?us-ascii?Q?GNmdcQ4/GtGpxhCWUo/CX0ebclBGi2K9q2FRssFX8GlLS2lEONmUrkKpGAIH?=
 =?us-ascii?Q?Djwnoka4T3U2Zcscb7Cw8/GTnW8YExAspSf+uROfJsevMh36sDWnQOUc8pqf?=
 =?us-ascii?Q?wPkS4tZ+r5+gWMO3abkGLALpJRo1j0uIxmqSuJlBfV0+Vby6TcivYhevbg5X?=
 =?us-ascii?Q?UOmzl8Vw6nKDUD+MwC4zHMKEcsdOvC+wCwSntrSnRJXEzfs+oh3SR73rEHbB?=
 =?us-ascii?Q?ZfzOYFQggVhsgpYR/+klsIVGgu9kLAAL/n0Swvkk28y0OSvDEhiSPne5+TUR?=
 =?us-ascii?Q?xL1NlnfU8llgmFKV8u03Yzj6GCBEY1q5xLBCJZRKJEjhDOsrB76AcqNpR3Y8?=
 =?us-ascii?Q?7wPOb3dhUJOYoKqWTdlrmuUa/nsk+w4UxfnpV7V/BsjSDsuE5AqFvi389khg?=
 =?us-ascii?Q?6goLPFPc+iJcV1RHn7SqSqTbrCKmpc2RRvOq8sJX3T+W1MLGxUYyNBvVSsF5?=
 =?us-ascii?Q?1pHTZdFu7b4bcebcrp+/uIf5G2Mqo46bnrcG5TiOhsbC+1GcfKgnnZyEBShV?=
 =?us-ascii?Q?adpTqoGCXTFR8AhuWKz9bsC8ttdRQFRAbiUSEXcfnCHjYEgGmRffjR+9Ra6Z?=
 =?us-ascii?Q?K7usFc5jhA5TqCreBJyw6V6pC+olo8bENE5XERnC/hgs+oEDVYiWOdrQbHHx?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5lmZu2Vc7OdnnwoRTlXW+8DtiFuh5bBoDWQXA9sxb7owgo8q9Ioi+op3dZST8C4uyDDepRXfiO5pysslER+ISBO55J7nLdJML0L7y9KAyhVh4BoPEdwsYRAMWhpFcjfxV+S56L1apG80n+kJ2fNrCHSKg6/aFbuHEGvUOqI4DjbDUNxX2XsjPfjMwG3/YOKb2niwEIfqdIep2nSt1fbh+GIiY65IBAG6SXhbHSICmsEZkVsiQS1rP5Vo6ZkF2Swgik4WzcsBHrfKplcjeT1OhzLmDHBuLx+APdXpM2wYYO+8/mUyiywa/890kQ8HIc8vUnMMGkyVcsHBQPqfCCtVx+lptS0JgtWeonsdqjayB+pBIucgO/LPZ8ParE86IlYWDwkSWCjSXiKtpcOh+EvPspRF/x3rN1IzsNVYMhUUDaNhIknuvUpNdXzXUmESMmdeyHrz/CA36P+st2j+wOoI9jMDDwHeRHd5jmtbxx+GosMJovrAKnZzMbyOFu/2pWKyip98YywHfk8CypLr+ByKB7VWxX0CCds32DA6tJPMPB+ypsz1hpCN6llQ1bF8rBev6+ZX8hC24I4phkx9DGb1AyB+sP8EyQ8Pe+LEL5aJpVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9b4ec1-5cf5-42a7-066d-08ddd35b29d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:31:05.4112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LHe311RBX5Ywg2mrNWyP5SB00Jb1UpfULrUZUdUIqdpv5sEdjRB6HpGc6IMu03S0Sz/YKIU0LsNz26d+Qg+LfldlLUurpxSEY/w4EzJFyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040074
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3NSBTYWx0ZWRfX/cczVgEwFdDq
 6un822egQSZs9fgC4A4Rw5Y6uS1lV/XIH+0EOOdL+pSsrERgumviuKGtVZHXcyqWVwKG6FCiBoo
 kprVnrwed/EexI9gHez5RYtVckGq35Ye+hvyHRcYV6pr+nCLIxedKZliQxf5lEbluMyVFOwgFzx
 T+2u+TaESpY+BEeWHiXp9/ZGOXSTiuyvq//wcKT3E3X0o9wnoIyi/WB/RXYIMOByxKHTnX4phqa
 2Dk3I8vug9bijZJ0KdQ8F8q98SckY1DZJ1ZcV+2XnuLUXhdvETWF0RvbLLFEGzgn0skN/NDY4jv
 gSoeUPuflmPzbPuhd5W3xE9ITwS3VAHZnHa9rrq6R+A4PRPjObAQwMhlhsrMPUGB9o1mzkxdF1V
 X8sT84paYZpG7UcBbOLzSgfDhYAjrnch0YMwDVMze0weJZYZLXvsUxHngLbfGa//6dreIsz1
X-Proofpoint-GUID: AwFa-UnWOI0zWDd6YG2NIFajMqtmKwa-
X-Proofpoint-ORIG-GUID: AwFa-UnWOI0zWDd6YG2NIFajMqtmKwa-
X-Authority-Analysis: v=2.4 cv=VMvdn8PX c=1 sm=1 tr=0 ts=6890b625 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=cruQpLOzQDgxFGfOXy4A:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10

On Sun, Aug 03, 2025 at 04:17:39PM +0200, Alejandro Colomar wrote:
> Hi Lorenzo,
>
> On Sun, Aug 03, 2025 at 12:15:15PM +0100, Lorenzo Stoakes wrote:
> > On Sun, Aug 03, 2025 at 08:47:28AM +0200, Alejandro Colomar wrote:
> > > Would it be possible to write a small C program that uses this new
> > > feature?
> >
> > I could do, but it's an unusual use of mremap() and we don't currently have
> > example C code for the _general_ usage so I wonder if it might be somewhat
> > misleading to have example code only for this?
>
> I didn't mean for the manual page.  It was more for helping review the
> changes.  If it's very small, it would be useful to include it in the
> commit message.  What do you think?

Ack I can do.

In discussion with colleagues I also realise I have to add a little more
information to 2/2 as well, so worth a respin anyway.

>
>
> Have a lovely day!
> Alex
>

Cheers, Lorenzo

