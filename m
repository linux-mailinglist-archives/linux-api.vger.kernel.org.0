Return-Path: <linux-api+bounces-200-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A517FFE4A
	for <lists+linux-api@lfdr.de>; Thu, 30 Nov 2023 23:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8666CB20F9C
	for <lists+linux-api@lfdr.de>; Thu, 30 Nov 2023 22:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3376168F;
	Thu, 30 Nov 2023 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="ZXt0Eznh"
X-Original-To: linux-api@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0606D40;
	Thu, 30 Nov 2023 14:04:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7S89jrK3WIdrFOpR7RSAFo8n8GF4S4I2YvO+M0cWvnWH4tmGkLgrg3KpraSMqLoUk6US/sp8EDJEn2OOR+PzB8L0EagXb5EgAaJSKFnJGfzHmJsvDmlg/qdWSCD6yEf3qURhm1L/Nu44OdYfRZWQ2jLSoO1j+CxqurMvnDjldEXa8RT0t6/3+yEaFwoK7sGGaWdzr+cfvvhYAVQTzAlXKm/mK3Y5akPewlkiBOULk8b3LyUShXccb98qvyZPO2G3l1vjHM11MrosyuwJthPTR3XKCRBTsbc9k96gdXme5wjBFICGGlyC+ssmJv3FaV7DQg2qfPzFgCGRJBCFkDJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2axCpfEpUw/lFBX37+lqcZ+XwWsj1GhOI3zXdhsSKZw=;
 b=hjOkqMX8kp8sF4ChS0nK1xL55Q8trdjiHgZNCl16Cn06Gm1OPo3b+TwTbLkab2Ur15qnSIlqaqW7cyA5UY4hfFm+AOFpSVIcDi6ps1Zbqyyz13tVgbfWGTL1x/MozLYroZQcwRUphKXNbnEofntToEG5KFtajeG/LCMqs7BNi49CmyifV8NI9F0bHHB9kT3XtMoLWouzUDc1xOh7lNW89q9qBoEJxIMNkKhh3loMpPvX86csiIm6H+JQfc1LAueLJZ4rMrUaTi1CWYDgP9Rp5wCUp7eE0XSqvF7XYjIaDQvwW5GWnjnqsBPomPL/ODilbLx5VRa6V7DctfWNVHZISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2axCpfEpUw/lFBX37+lqcZ+XwWsj1GhOI3zXdhsSKZw=;
 b=ZXt0EznhYjSj0sjg3nzljzTS30Mb9aJOzeo2FFoXFqWiDqiVIH5FmKWiVPDoiURyyLA+7KUoODB0/iOwofaJyOyrYqKdFvNwpDq00P6MYuSeT8bx6WdHzOENOzh0ADb70PYsF9aSeQjuaAqeURkLqYK4Tg35HiR8cnDKG4rL8U0XbC6UswUxdpldLepDf29SzREowxS85qEu6P3FeybE0c438uJ7Rpm30CBk0VayjH3lPymcNu1FIchu8ZMy3/WAoGoBBVfWdchPO0SoOVCrj8pqRWr5OQ6s4wuHKRR8Rl2rQHqt5JCyf92r0EurWcTwE0ji0dL66SPcfsgiFs0AIg==
Received: from MW4PR04CA0084.namprd04.prod.outlook.com (2603:10b6:303:6b::29)
 by DS0PR08MB8490.namprd08.prod.outlook.com (2603:10b6:8:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 22:04:46 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::9d) by MW4PR04CA0084.outlook.office365.com
 (2603:10b6:303:6b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Thu, 30 Nov 2023 22:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 22:04:46 +0000
Received: from BOW36EX19B.micron.com (137.201.85.154) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Thu, 30 Nov
 2023 15:04:45 -0700
Received: from micron.com (10.3.67.194) by
 RestrictedRelayBOW36EX19B.micron.com (137.201.85.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Thu, 30 Nov 2023 15:04:39 -0700
From: <sthanneeru.opensrc@micron.com>
To: <aneesh.kumar@linux.ibm.com>, <linux-cxl@vger.kernel.org>,
	<linux-mm@kvack.org>, <sthanneeru.opensrc@micron.com>
CC: <dan.j.williams@intel.com>, <hannes@cmpxchg.org>, <hasanalmaruf@fb.com>,
	<haowang3@fb.com>, <ying.huang@intel.com>, <gregory.price@memverge.com>,
	<mhocko@suse.com>, <tj@kernel.org>, <hezhongkun.hzk@bytedance.com>,
	<fvdl@google.com>, <john@jagalactic.com>, <emirakhur@micron.com>,
	<vtavarespetr@micron.com>, <Ravis.OpenSrc@micron.com>,
	<Jonathan.Cameron@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-api@vger.kernel.org>
Subject: [RFC PATCH 0/2] Node migration between memory tiers
Date: Fri, 1 Dec 2023 03:34:20 +0530
Message-ID: <20231130220422.2033-1-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|DS0PR08MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 115df915-807a-4133-c623-08dbf1f05d55
X-LD-Processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 mrOtc6/Uxeup+J62YVmFw4nRB5i8xcQkXQ0vFrqAfAR9xbq+QaTDZo86toDxY1Qh+BkadOqlFwcPJY5euN3aTpKVRSpfSQH3oYHT9XYD55tbc8z10u70tb6GSZp1jzhP7E3ZgHvD9luHyrS5paFq78ybJ+vbJlFjX0fekMhUJCaIub3l79EKzlSVSeL3r1hVB2cdnaHVRPRSD5+hWjU+e+Teb5nFu9foQ//dgmqVLv1aS8dgj6M3UFsvJsSAIQCGfM55PKe1nP7KtHofhPtRL+5ioBG1EApH7UWpcZNSNaV3uvJij+nPn8BWIKw8NH+uVSg9+l0eJt4X68ReK5Qk0WmuOh6YqiFriO6aaTNlUnvhkzZCQB+M/zRkYLQtlTrkULT2A18YpUhUOg0J86Wk7fqdR7aHwEbNsQIMjRd5OcMsZX8Hw9qj0x1VJi/EOCp2ZGpoRsmkhCnPTw4Xrel4KZd7f+61xqUWj0r001wh1OmJgdXeZo34nCt0upGd4siZ48IG6+9MbmjWqmM2rBSogUVkTwAUA3u5xMDTDfatyxQB1AuJlqIy0XlOxFyoJ+/yO/i9p1tUyFQXLz6KH2iEwhORXzr+/ToDOwer5GQKbhYRnqZ/nQYGWMthnEJGUlnNKzPeD7fUqg2JwX66qutiX8rzqzmSgHrq69BO1x+8LVQ3V7+SMlIw80QknHVYk6IQFF/ytlPC/wiPyPiPbKQ+qNnH/mhkoeLQt55i2Hs3jC9jC4fAZDa/5lkU1MddFcy/NS6KjCESc8qiKBaCF0uuww==
X-Forefront-Antispam-Report:
 CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(7636003)(47076005)(83380400001)(356005)(40460700003)(26005)(1076003)(2616005)(6286002)(70586007)(54906003)(70206006)(316002)(2876002)(2906002)(110136005)(8676002)(5660300002)(4326008)(7696005)(86362001)(8936002)(41300700001)(36756003)(7416002)(6666004)(478600001)(426003)(336012)(82740400003)(40480700001)(55016003)(36860700001)(7049001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 22:04:46.2467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 115df915-807a-4133-c623-08dbf1f05d55
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR08MB8490

From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

The memory tiers feature allows nodes with similar memory types
or performance characteristics to be grouped together in a
memory tier. However, there is currently no provision for
moving a node from one tier to another on demand.

This patch series aims to support node migration between tiers
on demand by sysadmin/root user using the provided sysfs for
node migration. Each tier has a start abstract distance(adistance)
and range.

To migrate a node to a tier, the corresponding node’s sysfs
adistance_offset is written with a value corresponding to
the tier’s adistance.

Example: Move node2 to memory tier5 from its default tier(i.e 4)

1. Check default values:
$cat /sys/devices/virtual/memory_tiering/memory_tier4/nodelist
0-2

$cat /sys/devices/system/node/node0/adistance_offset
0
$cat /sys/devices/system/node/node1/adistance_offset
0
$cat /sys/devices/system/node/node2/adistance_offset
0

2. Move node2 to  tier5:

To move node2 from emory_tier4 (adistance=512) to
emory_tier5 (abstract=640), set the `adistance_offset` of
node 2 to 128 (i.e., 512 + 128 = 640).

Tier4 adistance start can be derved from tier-id
(i.e for tier4, 4 << 7 = 512).

$echo 128 > /sys/devices/system/node/node2/adistance_offset
$cat /sys/devices/system/node/node2/adistance_offset
128

3. Verify node2's tier id:

$cat /sys/devices/virtual/memory_tiering/memory_tier5/nodelist
2
$cat /sys/devices/virtual/memory_tiering/memory_tier4/nodelist
0-1

Srinivasulu Thanneeru (2):
  base/node: Add sysfs for adistance_offset
  memory tier: Support node migration between tiers

 drivers/base/node.c          | 51 +++++++++++++++++++++++
 include/linux/memory-tiers.h | 11 +++++
 include/linux/node.h         |  6 +++
 mm/memory-tiers.c            | 79 ++++++++++++++++++++----------------
 4 files changed, 113 insertions(+), 34 deletions(-)

-- 
2.25.1


