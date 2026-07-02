Return-Path: <linux-api+bounces-6772-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NsT8NFfXRmrfeQsAu9opvQ
	(envelope-from <linux-api+bounces-6772-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 23:25:43 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE2D6FCF09
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 23:25:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ksuHuPKh;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6772-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6772-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35AB83018756
	for <lists+linux-api@lfdr.de>; Thu,  2 Jul 2026 21:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB93911A8;
	Thu,  2 Jul 2026 21:25:40 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E14138332F;
	Thu,  2 Jul 2026 21:25:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027540; cv=fail; b=bWXERcO9xYChUYrrdmPdTXiZMpPFPxClhSxXP103fTfeTusY1OPpyAUyWWnKwl72Cu6sigXCM7C8d5DHazdExeY83KweMWQAqD2Atf678bvM+hXGSmwyuNtX8drgyGfphDrG0sREzGexOKiE3XJMnSPmJ3+S11hb3qK0zQ+5Ky0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027540; c=relaxed/simple;
	bh=X6cmTMvQMA6kB1M9YhMuOnoeBB/Mb9ZCmFz2KZqCIeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OGmxdtxYq27xzfdfmw3pBwvUH3i+nNhfnhFQj50cuPWW3xoki9/flfyq5XTDyJgAcWlRvXQmRObHNdIeKutC1EpAwFN/EGMHLH1aAPdtulFLMGkqAYidQss90Toj5E7CgCbGBcQaYLuC7Wyfc688D6CmoZny3mCNwM/I8NnaiME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ksuHuPKh; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdMYOlYw5JvCq5zJ8UTmthId1rC3E6c9qBdOr8/2YVpoW/f2hpyZErom4PiGZB/h4f/eAcImOLgVVQNehpCEzRTHqULzFOtDsIAhePVk/WJSQJRRzvKjDpO2vaxXEegLAxeYBakIH06wxUirmTWXnSOZasQJfdcGxNR8IUn/Rbr/sFXGJRGUFapzFUiB4mboGSkHMbteYyfm8CgwRSjsfyX52uBKyG93OKdVX9zMlksGYDHifmyV/6Y4I79yeVjr+prweCx2G1OFAmqxVA9s525LFP4rQuR1EuTXA0qPAHNcUjC1yu3bTxCwgUFmVOV67cZi2eO+iZPcwIkNofkWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvuwNlRboyC/oMNkt2MaNQaodDRbWhyXj3VHeQZ9TiA=;
 b=m+xHLg3iYn/ETAH2xAee/rdpBzgkBxhvJAljorF5+LEAK1aaI3PXmBwTsucCiknAkiUgIe1AP8iu1Tyd9mY9iORE7xO6QCOasVfrWkBFpi39U5NSAuMy+bBvakEXbqcoqgN3n91pyF4YpA5jZgoCgCrLS24Q7dyRYsNc9AGOxZcgA9Sh/H6X2Oq7IyO15A6Mu6KXXiy7I3L9nU38MXMyN86jVf4W3QlGzhuiA2gXW8qDA6tM+OgbCckmZ1Ri9QcA6aB13Cc4h5cjuT0aNiJzy4tkfPwcv/0avRoPqYULEOrzcllrZiNQy+qUu55E34TTR+oB7ElFnx1b/DY55lewDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvuwNlRboyC/oMNkt2MaNQaodDRbWhyXj3VHeQZ9TiA=;
 b=ksuHuPKhufLZHM3CtfxHIYzUSukV0EACSoTGbN4jSCdvojDKuABe+tvEa4l0ucHZgVwjCQoP6bsnFJvotmCMiDdVszPiENZFGwgcSXsO8IiDyYc7Y6pUNOZuu8xn1PXcrj3ckzyKQ4LnxoXdLcXBNWnd5BGeZ9cnKsBjOGIqW3JNbLVOUbruLClWcVldKU4ynYvSxkvrohqR+uVaF21E1BXUXNO10A5a6TIDoWcmgqoJ5kAHkxO5m+PNnGqnPWXQnsxnBG6A1BTyyVzCyiuCuKn6iFG47ABHT3LrIULwGPKu1nN0Npp5JPDFpmxgkaxdF2S6TeqXTL+lS3UlJKYtcA==
Received: from CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 21:25:34 +0000
Received: from CH2PR12MB4168.namprd12.prod.outlook.com
 ([fe80::762:c8d0:c9ed:ebcd]) by CH2PR12MB4168.namprd12.prod.outlook.com
 ([fe80::762:c8d0:c9ed:ebcd%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 21:25:31 +0000
From: Jonah Walker <jonahw@nvidia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Jonah Walker <jonahw@nvidia.com>
Subject: [PATCH] drm/fourcc: Add P212, P410 and P412 formats
Date: Thu,  2 Jul 2026 21:23:55 +0000
Message-ID: <20260702212355.1072804-1-jonahw@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::27) To CH2PR12MB4168.namprd12.prod.outlook.com
 (2603:10b6:610:a8::7)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4168:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: d06a900c-2083-47a3-b6cc-08ded88071fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	n19336n1r8NtP0irk2hz6a+cSsGL8gAVbpJmQexjLtRptw15JCD9tazdJfG0dcta2QBKG89cLnsCfHaT8VGATz9c9YOpgcZqTEVryLd//ODdJQLDj5UILiGJYYff+P/6Vs7yf5t4OJiLEBaIfcxyaOXHtXOeYr3YUfefs+nNPRTfG8mMNYD/z1g6dOA5aW8DWstzI979TKjn+I/t9p+jkDb2pcvignUFjyWVTAKI/V9Jf/2x5CTFG/8Pk/hSUEAotGhJMm4yPjn7NElMP3M8jkSfIFSTf9dj8gcpqmHPV0m2jSJB8LxA6HW+gPYiSu/eoCtHbmIuBRK6wzftbuc3f+qXzBpp9S+r2lzFlsrhTut71Hcxo5cm4m/fLGqwYHUgqCJyo03zyC2hjr5BSCYxwD5LoSYzXJZom5u5iT7KS7LZWhgom00bHmhkR2X6hmw3OcU6Snc7Bh4K9EghPSXsbTqErHBDZD7KJaaDF+QDvM/U6T2K22QATNEo/jE7ebSjolIPXgAR5tm23dls+gJmJkbSiGs03mNH4Z0vwIojS83Rogfq0v79+PHG8pvJ3DBX6A7Cn3rrXyWyWaQVyMO68RTRG8bOd8JmD0CjkxAB1z7sVVqUZF8DxeeTWSK8eU0myx2mZvfbRklHcYifwOqL1mtxKGF2lxjrEAYbRz2yEwE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4168.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ivj7Lwa6nVXHq8AP0y7c/Gdji/ZyLi94/p4AsxLHMgQJdCGe7tZJZubg8Ec?=
 =?us-ascii?Q?lGfqm5zXBzm1+Q1Cw5EOHgoL6XpNk48vLC44jVrZTaBIQanuuWUWwxuvaoM0?=
 =?us-ascii?Q?QvU+N739pmaIlImii9Bhzwn+LGggQQMb3JMSFwVMhUlGEhIeTBqghm8YtuDU?=
 =?us-ascii?Q?L+NWQ5sf/bkNhSJJBml2UYgUj4H7I23rGFHsXOzBhjWcx90BVj7FahgUrUwM?=
 =?us-ascii?Q?JDDX6xeGlv5Cc10iYClGRTx4einCl87rcCRP9crhPAzaxQi1j9QWX1PQ/pRh?=
 =?us-ascii?Q?uwqUhNzgrXM9UJXxHi14W+IyV9hnlMlM5YWxJvFRNQFuZxtuhYlPHl5RT48V?=
 =?us-ascii?Q?FhI4eElO4BvPrdPhu6qNBfoxCWxZ5P7CKzumOgQqwQ8ccuxY2/YQmUPJUi/f?=
 =?us-ascii?Q?1/0KEKOixfoK2qR2dsVmR8tZTEUAt1jTmTHrKVwG0e+ASAv/pHonprra+X5T?=
 =?us-ascii?Q?qGn8c45DFY8haK0XRI8pFs5XDFpVuI9An8dm4G+0pSHdJfXV6d0wiQjXgME3?=
 =?us-ascii?Q?LdjoGdE/VlBm4p8IzXCMVGC/DSTk9ycybz89s1W1f8ISWjLI2Cnya1FqeXrO?=
 =?us-ascii?Q?uJ3UKs+zT5zZPQhCIo5KcN4OPC7Awohb8z8YF8fzql6xsvN+KafTI3HXNv8f?=
 =?us-ascii?Q?YjhtXMfs7rx8Dc5joXoBqOrMKEJihmQu+vL6A0hSye9xrqJoZPvqYtvsJHGx?=
 =?us-ascii?Q?4UAcdd8XiGVirVLzOGL6lGEygo/epiJFMS7LiSkF48iEelvTNA8ioJzwGTXZ?=
 =?us-ascii?Q?A48/FkRuvi4q8BKCqO7pBBqSkLRdLhQfw/AQIEKYK3UNHYUWACqqZ8/k9wLy?=
 =?us-ascii?Q?tp54QL7hhl9VXq7FDmuYBQpX+096WQfyDr/gL8c58+mX2nB2UUYzlEGTpU5N?=
 =?us-ascii?Q?Vv/KODDQvp/zn6QLJ4q+O+FtQB5J4y3FhEcXgp8XMND8iieB5Pm0r+9L+CYZ?=
 =?us-ascii?Q?T7OHStEB2szlx6vx+DiIwPXer3LEoAQ8kkeD748/BQiuTXV0DDYpHghrbdZJ?=
 =?us-ascii?Q?lpMxmzAsdTmiUPzvNbrc93vyVxAaoZzZV4KfBtZiVZGV5NGL/HzNkz228jx6?=
 =?us-ascii?Q?ravFtuTF2pq9EhDCpjg0jBB2uRuneLOFiwuBVQ9IthqtujIXR+eOlZEBr14D?=
 =?us-ascii?Q?Jw/RBJnqemvNJ5frKOiM7/PJwq0/vSs/ASUFxkabQLkJpNHSKYcfTVOLimdD?=
 =?us-ascii?Q?VY0Q8t0ru25+uh6kDEYwmpkc6eTFfX4tKA6oxU99MUosZe6r+udNF9WdhmYi?=
 =?us-ascii?Q?34qWrPjChX7M0y1+YRc3Be5msDZSDTT3QJfgu3QRsUrU+VhBw6c0Lxmua69u?=
 =?us-ascii?Q?yc4x2EDPceSsAxdwqpWM9sRQzVlbpbjcaURFmNOiKIxg0aaOlos0/B3k7WiG?=
 =?us-ascii?Q?FvI5tUVsuYTvSdkRim8sx74BkxCcbS27eq5kgZB9tDn7nfqIkcM/BDdXmLX1?=
 =?us-ascii?Q?Y9dmKdH7gKCzaYSuA5Ynaz9R/giBEI/9XS8GpHFnOnve/C9Qkp+J/lIY7TGp?=
 =?us-ascii?Q?7Y4r+0SVfDU07wvq7Bd8MjPNg/q8XA6k8hRMLlcavLjboZW5UXHPJAgr7kTk?=
 =?us-ascii?Q?KTGPFBzmVm8jGgdU3gc7oTGY8irY7UxUx7i8ThA8rQUqjJNnbyOd8ZCrE/yA?=
 =?us-ascii?Q?4bSfVsgjMzK1CfwcT16r9P7Tk2N6gzgFyxHwy5AJ7QtF4Kgp9cbpoc16UMoP?=
 =?us-ascii?Q?hgDlH5MKO5JDebfQvAX0bqVbMTYjx+FKyHqkgbCVOcZZke/ZdNPU2qUaPA88?=
 =?us-ascii?Q?Q/BCmLsvyg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06a900c-2083-47a3-b6cc-08ded88071fe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 21:25:31.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmX9ckR7d2GUCz43U8nq+zWjRfTCvRGqckPzs0xUGySR4oEEaNiTiv63HjZ4PJHYXc0cltTxXwvt7WnGayTigw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jonahw@nvidia.com,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6772-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:linux-api@vger.kernel.org,m:jonahw@nvidia.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonahw@nvidia.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EE2D6FCF09

Add P212, P410 and P412 formats, including their FourCC codes and
drm_format_info entries.

  - P212 is a two-plane, 12-bit, 4:2:2 YCbCr format
  - P410 is a two-plane, 10-bit, 4:4:4 YCbCr format
  - P412 is a two-plane, 12-bit, 4:4:4 YCbCr format

Assisted-by: Cursor:GPT-5.5
Signed-off-by: Jonah Walker <jonahw@nvidia.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 12 ++++++++++++
 include/uapi/drm/drm_fourcc.h | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 60cd02b7e..31558a212 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -324,6 +324,18 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		  .num_planes = 2, .char_per_block = { 2, 4, 0 },
 		  .block_w = { 1, 1, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
 		  .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_P212,		.depth = 0,
+		  .num_planes = 2, .char_per_block = { 2, 4, 0 },
+		  .block_w = { 1, 1, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
+		  .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_P410,		.depth = 0,
+		  .num_planes = 2, .char_per_block = { 2, 4, 0 },
+		  .block_w = { 1, 1, 0 }, .block_h = { 1, 1, 0 }, .hsub = 1,
+		  .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_P412,		.depth = 0,
+		  .num_planes = 2, .char_per_block = { 2, 4, 0 },
+		  .block_w = { 1, 1, 0 }, .block_h = { 1, 1, 0 }, .hsub = 1,
+		  .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_VUY101010,	.depth = 0,
 		  .num_planes = 1, .cpp = { 0, 0, 0 }, .hsub = 1, .vsub = 1,
 		  .is_yuv = true },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 3a4d4dc63..d4a6463d2 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -334,6 +334,27 @@ extern "C" {
  */
 #define DRM_FORMAT_P210		fourcc_code('P', '2', '1', '0') /* 2x1 subsampled Cr:Cb plane, 10 bit per channel */
 
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 = Y plane, [15:0] Y:x [12:4] little endian
+ * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [12:4:12:4] little endian
+ */
+#define DRM_FORMAT_P212		fourcc_code('P', '2', '1', '2') /* 2x1 subsampled Cr:Cb plane 12 bits per channel */
+
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 = Y plane, [15:0] Y:x [10:6] little endian
+ * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
+ */
+#define DRM_FORMAT_P410		fourcc_code('P', '4', '1', '0') /* non-subsampled Cr:Cb plane 10 bits per channel */
+
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 = Y plane, [15:0] Y:x [12:4] little endian
+ * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [12:4:12:4] little endian
+ */
+#define DRM_FORMAT_P412		fourcc_code('P', '4', '1', '2') /* non-subsampled Cr:Cb plane 12 bits per channel */
+
 /*
  * 2 plane YCbCr MSB aligned
  * index 0 = Y plane, [15:0] Y:x [10:6] little endian

base-commit: cff96362794a5c1f3adb013b4a46c7233149a629
-- 
2.43.0


