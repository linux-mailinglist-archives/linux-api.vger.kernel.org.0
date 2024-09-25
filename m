Return-Path: <linux-api+bounces-2339-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2290986657
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2024 20:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052301C23796
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2024 18:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19CF13AD03;
	Wed, 25 Sep 2024 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b58H7KB+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PivJyfAj"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5221D5ADD;
	Wed, 25 Sep 2024 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727289140; cv=fail; b=P/0K3lLXGigNDtwg3HFovBWBR9GZ8B2o/BA4mAQSn3a5rbzU2geaMCt0XPvUZLpeXWmouJChINdcF12yoGtjPR5/2EsFYKgnd0nrxbH6Yer29Udk15+Sqnbii04WnCQy/3FysgQynS5Bfc6merEzhFqNdeJFZxnuPHPvmSCNvI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727289140; c=relaxed/simple;
	bh=f/ptZlc1eWJLNpL9BENrv1YfZTK95afZrOoylUO9FFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=emry7ncKEmwGU4DZyERvJG7cRJwlmzv9Su/QICi84CZ12Uegig9fAUex1HK1F3g3UFWnM/4hDXLyxj3IOPaao3XZo6m8TRPLf53DaUO2Djo0yYw2k07QEpg7xTMdF64oSQRGu5fn6+5peKia73BclHqslrd19kZzuSLNsYtbvIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b58H7KB+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PivJyfAj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PIUPkT007848;
	Wed, 25 Sep 2024 18:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=3wyCDdCn72qgIvq
	DO9t35qWsl7fPdOEdWNPDUfRfuVA=; b=b58H7KB+LgdsAKh8WP408a2vmjPT2dx
	BmbLeyZ87edd1qB2jey8jqO5Yk9UZ/ZzofnNqCtzjZBmd+Zu31rtKEBUxe8LnJwO
	cFyNSH7I7xbnCiApYO3f54cJCceSbD6+8Web3Ly6o0JrzMs5boY8c3uKyDm0g/+E
	PV5GBriqYCcJKWz7RpdbDhjGBrG+QwIqsoPW7ofqTYAv+7hDBh65GaEqoBWV5PTz
	b1bAo17M80TXEBVfFYvbdfY12ts/5YLflKuLTaLW825M/va4L3UngvJBt6St538Q
	QGFsOpf2WMH/J0/TfsfakWLsfh1P66+aLdokn9C45LnKUjwgLjYw1DQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cu83d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 18:31:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48PIMRhs030408;
	Wed, 25 Sep 2024 18:31:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkb3war-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 18:31:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVG0WNcjmFn0PC7LYcEc4XfrEkxV9/4wELIln8PcYhXb/mz94ns0ZYFW6ElbjWILdux53Afa5krc4wiUB8LmcNngNj+SFqGlmedmLks1XE5FX77VbOQIiIqVwC5QabKO5+nA+xkoFAAMF4/HyDsyUr9DTEwIrnYNQwSmFEghEEMnxRcTtuiyy20pIQTGXOAC/Tf6Y22m2/ANiVAbgORu7r7SpAYsrqvJRLWC25AVV7/JE+kb7C6YkVQUy0Lq8P/C3pffB/MR+SOulwVROD5xSO2BmqAu4kYlGQZj9QKxLpmJTEuK2qJg/r+0DBf90kOud7ZmfVrdhqAJKhj8WiUoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wyCDdCn72qgIvqDO9t35qWsl7fPdOEdWNPDUfRfuVA=;
 b=C6hFvk+GuYyVymq3tjZ89Qenq3l2qzTPrWcHO1gjgSigMWvTEd2Bo7XOn1RiJ6x3AyRSJxOm/U9Dw16k0lXBRQpgDc9eNZ0/VOMtsI4g+tR9r/+GsyqjynraVssZbix6vjGX0JLeb9hGgPLXoScfYHtH95Kty3HtVTRTgfGaCEJqYh66LtVsRCCg3JG1CyHmr+q8h6TNG9Ixh3ySn575dKfrcyzJBtJbU/k7LmAWzfZriIJ2z1nOaWnq/tHPqPQrvdkb84QJ941D4uE15R+I/jlCe65y205Kbo6xu2xZs4KPeo3NBfCJ2XRSOq69gfgz/gkNfHp/9J8cnPAP9TuBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wyCDdCn72qgIvqDO9t35qWsl7fPdOEdWNPDUfRfuVA=;
 b=PivJyfAjovuByB03m6eYj52kNfN1trSUgv8BYTAjFdIhntZjOCl6iw5Zt+AudvrbpZcyx3EpwoCfaWERiUicZHEDd7ICHdwnYi2AD+LaQlGZn1hBC1EmWikx8oonSIYa3ItWMlnaCzVZj5/lN7Hxt9QPILJAO9HHijjwER06Q0s=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB6222.namprd10.prod.outlook.com (2603:10b6:8:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.12; Wed, 25 Sep
 2024 18:31:39 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 18:31:39 +0000
Date: Wed, 25 Sep 2024 19:31:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        christian@brauner.io
Subject: Re: [PATCH v2 1/2] mm/madvise: introduce PR_MADV_SELF flag to
 process_madvise()
Message-ID: <9bad20fe-147c-409a-b3d4-36292266ad36@lucifer.local>
References: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
 <1ecf2692b3bcdd693ad61d510ce0437abb43a1bd.1727176176.git.lorenzo.stoakes@oracle.com>
 <u64scsk52b3ek4b7fh72tdylkf3qh537txcqhvozmaasrlug3r@eqsmstvs324c>
 <4740dfc7-71da-4eb4-b071-35116288571f@lucifer.local>
 <xilfrvlstq4fqr46jlrzvq2vlr22nizdrwlcdizp774nlt6pfj@jukzlcwc7bed>
 <7f40a8f6-c2f1-45f2-b9ff-88e169a33906@lucifer.local>
 <wvk5y3m47qmox4by6u3zpxtwartjmoaqaaqswbgui626zkjajq@22wjmqo36hes>
 <6b449c32-0954-4db1-9df5-23b766dc2d9a@lucifer.local>
 <asbdij3q2iabrnq5wdxmcq3g7ofut2malicushswi3rma6glf5@k6eftopwmwvj>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asbdij3q2iabrnq5wdxmcq3g7ofut2malicushswi3rma6glf5@k6eftopwmwvj>
X-ClientProxiedBy: LO4P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 25df0c62-62ec-44e4-d910-08dcdd904b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JKmBe7W0jHrVa5ZAHHXTa39tKqhjCS0K6LNDM7JNWviINwJL5klcgmEewbGa?=
 =?us-ascii?Q?FN3GnVTmkaHoBOwvUQ3sV9qkmDFh8+c4cDpKIqb2INeSaYZD0UbYWFkowiR8?=
 =?us-ascii?Q?38OUHO8jv1C2rzFR+e5pagA0a4HLLyQHDHOKGXin4jxN/JDTlqhWC136jrux?=
 =?us-ascii?Q?6jymqQgpag3L0f189Y0MSEvV62edJxFuxdGldUC1TjlVLfg306l+GlWgUnaw?=
 =?us-ascii?Q?3uquVJz78lVTeGWuLqr8I/kU7iWhwXsDwnmUWPvRMczuIPoZN+MSHHZaMTiu?=
 =?us-ascii?Q?KJGuFxIFBfhPRO1DXFPEpwNhoLhzDEFW+uMDvpA4UuYrbSZ8v5bMEmQuHx6q?=
 =?us-ascii?Q?vLW5UNvfYpAetL6YYeTTE9cCu6CqQe80SPsAwsQ/B+9E2gjs3bT/DGdOALEh?=
 =?us-ascii?Q?roDmKZGPw1lYA9ZmgKMReyTufohCFYAFOYWeJztUi79gpnxKYM9iV/gvVsAn?=
 =?us-ascii?Q?ryGESl9NmgAgKkOGjrj8NiKB9FDXiJD6lWqSM0bvDjhfafPhWW5ZpIVkwG3w?=
 =?us-ascii?Q?kFnIYg3aQ2NNeUKUmk2eHeEOogZqrnfXAEScXR6zApCubtTDTpzGfg10wZ5x?=
 =?us-ascii?Q?oj0tLyRpe/jhc4ItEUijSQs3BtyijIvytsk6ML7d9pfTo0aaAF6VGcz+ffmx?=
 =?us-ascii?Q?OvNpPbgB5aMb7zf4uVh21BwwCyB1pluRsrE9twnG+4Uc57GBFRyZVKKYLuhO?=
 =?us-ascii?Q?voh5wJRsb0nR3jLlNucTawcBg4hgg0AnMApkTFkRJDwBDIx8fP63wFJNqRM1?=
 =?us-ascii?Q?aKIYldUtSbAGqO36iVZMQuk6uoCc7UwYIifa+l3gG/nHoETm+9OGX0aHquzV?=
 =?us-ascii?Q?QJd4WKXxmxopl+BagE2BaBsBqb2g5h5dwDH8d8HGeQZ9LXL/9qXh2K7+WTn9?=
 =?us-ascii?Q?teGfKySoVSiu2hH+EkG9Q49sAQAzdKg1OhpWnB6BPatEZgCUZ3Fo8eyW6i0h?=
 =?us-ascii?Q?Mjv0ecPCelnGSx7P11xAjUkoCPbnUHQDjiiq6oeBEdfZR18BlrElAaz/TgYn?=
 =?us-ascii?Q?D8MXwCN2goaiBaO+S9HxG1gh4kNMvaqXA9G0saJO7mzVx4+RS0uKO6AVoUwH?=
 =?us-ascii?Q?zvpdt/Rqy6PV0puX8OdQkblIluB4qZLewIvs5A0RLTxllZc8nVUmnhpF88bA?=
 =?us-ascii?Q?ul0Amte6u0xNWzSC5wGFmCBpuE1554zb0l1Sw5L55GSKPHN175G+6dHdt1X8?=
 =?us-ascii?Q?+w9CcTR9VhUGU4QPW28sJZFhpwZgq5e8hp7Z97CnFMtkCkdV+X3fvE2PLHTr?=
 =?us-ascii?Q?zPRffsFhour8ZgPQ/u7o8wUZAb858VMuU5Lmene6eDjB5j+Qj9X/3PMp3vpb?=
 =?us-ascii?Q?v1JRHxRkP+oV+CS+IWvyyNMSdu7Gys7pKWSNZqNPK1msmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fRPjis9lMvmd9IcItMqR9jcJS5ljE5f2qAbNTS5VxIM4sYY/nDvIvcYXbVdx?=
 =?us-ascii?Q?h66gOd76iV/HaEknuoMxYspDsxyGLtVdbLsJVsk4asJ0AjvVJqKHo3teWTXy?=
 =?us-ascii?Q?GCoffUathnEcRzJSuxREaVIXh3MPouMu5MynUwkNI7EQZZIMCM3ms1l7IZf/?=
 =?us-ascii?Q?eMptAz5o4tFWS3309X3Dv3xK/B7TN5k0W2pkpPk+p788z8o8irDFUdNoQIy/?=
 =?us-ascii?Q?NuUG9WSm4Xvwsucguvton76QGa5shg9Y594yFHPmVejm12n5PbneoQgnABeB?=
 =?us-ascii?Q?Dv0kauNnsUGyu9TnzWg4PvbWynJQyVkjDoUPOKteExK5NgtTnBNOB/9okQJe?=
 =?us-ascii?Q?jZs1IJtNGi0Ov5VTdmNlKlUL7qtdwQq81M2ekspCJxGVvsM1j4Ovy43Rt7pM?=
 =?us-ascii?Q?yQH3oKYVx7nmssmlceX8I6IF/wcNkqWWnYv2vkP42n7BYbnGrhpdiLsEdnWZ?=
 =?us-ascii?Q?7dE8DsCJGPJgtCkvsEdLe7bn9cVXuRoTITBnJmlX0/H9gMf5gecOOOwCfMsF?=
 =?us-ascii?Q?duA0pWi6RVHJkpBn4xvstgUGlPAOTK+kRDXPUbOJbAl1r7Jd0mfMf68sxQj9?=
 =?us-ascii?Q?4pmZLoko+t6/kQcH13PRpLkfX3+lxzW3z3AZud0NAbGGFZ43Hrlyd8+EbqpK?=
 =?us-ascii?Q?738wPZSzoe3GSFFls+5j9ARpnp60iUSP+QV7knP7glhd6sLLbw9BRIbAJyx7?=
 =?us-ascii?Q?QyI93AM0aeSDixFwTKwJLVfsbbpQcyIS4iq2Kv2YAbtK2CpSda3OvAXbByYI?=
 =?us-ascii?Q?eBgobV3fnjDHbqPK28GF4sK9VTdRzEq51Y0iw1O9q6rsqzqK+ChZ5Z9T2SmN?=
 =?us-ascii?Q?h2Qh12UWG6MfFoHcdbHLWbKCOryRmIkEJxSqkf/8sojW8aPszfJ4CREuqZ0k?=
 =?us-ascii?Q?f/kmp6AAwf1W3TTScGkXiV5y8ljcVz4nLwBmBLTJ651Up/6CqAdFGvHJ//7c?=
 =?us-ascii?Q?DmK8o8ufnTfAq+jQ5w8wLVxTPCfXdhnFII1fzeX7/ru8olXgqNqX4eTXqy3M?=
 =?us-ascii?Q?Ay5Nn9cT5J2cXW2cCctU7sznL/cNHFiBABgefvL+9DBAcDZaqkHwItRwKo6d?=
 =?us-ascii?Q?g+57vpoLY3ltfv6YvLKfYBqe/K+ux3AgqLtBvmByld9MX6O2lzGQo7CCetRC?=
 =?us-ascii?Q?NwfzyQ7lwBOQXTmaqUoVPXbAwCLRlc0FEuhEJJoY8M+kNbbDKaX6/a3/J4Od?=
 =?us-ascii?Q?lOy+5VPeXDepDARlMT3MvC19RPtKUtFWDBtaE/QtzlFa6Cn6a/mGclBMTcJD?=
 =?us-ascii?Q?8h4Q0OYR1EewhNoewb96auyd0kVUYdBWg8UZD/fhYxVjrxxmWhL0ldfHMm59?=
 =?us-ascii?Q?lVnsNK5C/rK6kNTj4ReiMnHMC+I0cOnEJVAXRar8AKqeKEkl2o5OkO+WrwuP?=
 =?us-ascii?Q?nCnaUMjEMAkPY5SxnG2sjQdpLe5y53mkPt85O/EFSFOrtrUjBykjpwBXiUbO?=
 =?us-ascii?Q?rglyQTty55rqURmz3fIHgDtKMcldznGE7wmE5c34b7Pzy8OFI0W9bAtUuGtL?=
 =?us-ascii?Q?aFF48HyBDJNs9y4auR4pNScTF4niZSBT0snxhu0s18uBuk3B7xcB/zk5R0xT?=
 =?us-ascii?Q?eylgD5/MQEjETv9Qo8iocONSdrT2aOmECS5iVYPoc9c8gd6hwuzzUotXcNDc?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3Cm41kvEL0FGV04BBrG8Zd9Mau29fo39dRrYLK8Vo2qFPR0O1gHHqWrVD6td5efop1xj55lVIRQlv6x8EHLiAVRsylF1WpQU7qU7E7FdTZ7AA9gEQ0DSalxL3nKPnWw1leC8Prsrr2qBuYhFnXM1cFzzjz7AqQAmeeTw1FuP+MVa/Z1rIlEMsifo3o1KrGSR+7cIXpJpytpWrADb4MS3CrGvqT0Ri8FWllgyAlfX4PlXQofSLnM5akGXczze4g3xEOrpByu9vXBQ4UAhr/T+cz2pBUihh88pqUDdSdbAsXj6v9yF3ef1Ghleu8kz5/2XSRD7IDLmi4mYZ5Ex+fUFKJ3xqZtM1QitKTlKuaAW+Te7vieGmrc4TcqyhkaH0Qnqg8VaJCyL3qe10p341hNjgCBXJSGpcVa75AlR36W1lMqMOiPd4noRGHVXE35FkMqQJqe365CmmJNt+6rd/wnPq4z6bwZyQb32KTBbMU1OwCTtPSs1lPMii0HJEVpuyxPe2Wb34CHWjNBK8kcZPBzcN8Blyegr98bVBHEqBtOshUhUjR9Cec2KfLua4DqmyKf+scc6tNappR/WolOpaZpChNy8FiVMthkZExNcho9hLOY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25df0c62-62ec-44e4-d910-08dcdd904b79
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 18:31:39.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXXF0yrv+n7s3+W5s+Y+RrFhnhLVReFhgvzfBtciSQLx40x+y4sJlI7fb3G2GGWyQBjftJZ61p6orM2bVaNLQMSYbyGXWQGQSGDjB6/D0e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-25_12,2024-09-25_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=956
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409250132
X-Proofpoint-GUID: zqmKPdFCB7oBoICsyORTBkOu2agVK9iJ
X-Proofpoint-ORIG-GUID: zqmKPdFCB7oBoICsyORTBkOu2agVK9iJ

On Wed, Sep 25, 2024 at 07:14:51PM GMT, Pedro Falcato wrote:
> On Wed, Sep 25, 2024 at 06:04:59PM GMT, Lorenzo Stoakes wrote:
> > On Wed, Sep 25, 2024 at 09:19:17AM GMT, Shakeel Butt wrote:
> > > I have no idea what makes you think I am blocking the feature that you
> > > repond in a weird tone but let me be upfront what I am asking: Let's
> > > collectively decide which is the better option (in terms of
> > > maintainability and extensibility) and move forward.
> >
> > I'm not sure what you mean by 'weird tone'... perhaps a miscommunication?
> >
> > To summarise in my view - a suggestion was made to, rather than provide the
> > proposed flag - a pidfd sentinel should be introduced.
> >
> > Simply introducing a sentinel that represents 'the current process' without
> > changing interfaces that accept a pidfd would be broken - so implementing
> > this implies that _all_ pidfd interfaces are updated, as well as tests.
> >
>
> While I suggested PIDFD_SELF, I never meant that we should change every interface,
> but rather adopt a sound, consistent strategy for pidfd interfaces and stick with
> it for the foreseeable future.

If we add this to a public uapi-facing header and document it as 'refer to
self', we will introduce something that users will receive and be confused
if they are unable to use anywhere else.

This is the fundamental problem with this. It's a fundamental, permanent
uAPI change which either introduces confusion - because it only works for
process_madvise() - or will need work along with test updates etc.

And it is very much out of scope for this series as a result.

I may just back out of doing this and replace this with something simpler
that causes less push-back (and fixes existing broken behaviour in
process_madvise()) that lets me do what I need to do with the guard
pages. I don't think anybody can object to a self-pidfd having unrestricted
access to madvise flags...

I may in parallel just try to implement the pidfd sentinel idea and let it
take that long time and update process_madvise() later, as I can't really
let this block the guard page work.

>
> In this case, we'd adapt process_madvise, then possibly later pidfd_send_signal, etc.
> There are plenty of pidfd interfaces that don't make sense with a PIDFD_SELF. Various
> other interfaces will probably never want to adopt it at all (select _can't_, other
> fs syscalls such as read/write/poll/whatever would require awful handholding from
> various kernel subsystems, while in that sense we would definitely require a proper
> struct file/inode/whatever for each pseudo-fd, which is not exactly what we want).
>

And arguably, you'd have to audit all of them and decide. I mean I think
this kind of sums up my point really right?

Again, I don't object to the idea, I object to the suggestion that you
don't need to do this other work.

> > I suggest doing so is, of course, entirely out of the scope of this
> > change. Therefore if we were to require that here - it would block the
> > feature while I go work on that.
> >
> > I think this is pretty clear right? And I also suggest that doing so is
> > likely to take quite some time, and may not even have a positive outcome.
> >
> > So it's not a case of 'shall we take approach A or approach B?' but rather
> > 'should we take approach A or entirely implement a new feature B, then once
> > that is done, use it'.
> >
> > So as to your 'collectively decide what is the better option' - in my
> > previous response I argued that the best approach between 'use an
> > unimplemented suggested entirely new feature of pidfd' vs. 'implement a
> > flag that would in no way block the prior approach' - a flag works better.
>
> I just don't think it's a new feature, just an established, future-proof way
> of doing things :) Your patch should remain mostly similar apart from switching
> the flag check into an fd check.

It is absolutely a new feature, you're adding an entirely new UAPI-visible
flag that is applicable to all pidfd's, unless we make it
process_madvise()-specific in the flag, and I'm not sure that's going to
get accepted.

It also needs to be separately accepted by the maintainers of the relevant
file header etc.

>
> > >
> > > By big undertaking, do you mean other syscalls that take pidfd
> > > (pidfd_getfd, pidfd_send_signal & process_mrelease) to handle PIDFD_SELF
> > > or something else?
> >
> > I mean if you add a pidfd sentinel that represents 'the current process' it
> > may get passed to any interface that accepts a pidfd, so all of them have
> > to handle it _somehow_.
> >
> > Also you'll want to update tests accordingly and clearly need to get
> > community buy-in for that feature.
> >
> > You may want to just add a bunch of:
> >
> > if (pidfd == SENTINEL)
> > 	return -EINVAL;
>
> It should already be there in the form of an -EBADF.

:) this is pseudo-code. And I'd want to check all pidfd handled it
correctly. I mean you'd think so right...

>
> >
> > So it's not impossible my instincts are off and we can get away with simply
> > doing that.
> >
> > On the other hand, would that be confusing? Wouldn't we need to update
> > documentation, manpages, etc. to say explicitly 'hey this sentinel is just
> > not supported'?
>
> This is a fair point, but we could also just... not :) which I don't feel is too
> wrong, since the fd works kind of like a flag here.

Yeah, no, I think you would have to. It's not specific to
process_madvise(), it's a general fd flag.

And like I said, if we did introduce this we'd need additional assessment
and review from those guys.

>
> --
> Pedro

