Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D811E6024
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2020 14:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbgE1MHt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 May 2020 08:07:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388789AbgE1L4i (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 28 May 2020 07:56:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7078621582;
        Thu, 28 May 2020 11:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590666998;
        bh=gs9/lY+1QDQ5E52V460MMXznwqxNumfuWvVTDb9U+uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cwk5HNVY5oKqBcAhYEPgfSIbrcNNxBkhooEL1G/bdOQj1iga9xsD6vRtaEmgBuscI
         UfKgQmDHlp/aI1jnxJ/eMFmYrVTDr6PFrNjyKYrfYRN+h8z92KXZDhCoLtn2GmNirz
         490/g8amptJLw/hkQe9vp7xkRb8u2ibiXyzpWSrk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Amit Cohen <amitc@mellanox.com>, Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-api@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 33/47] selftests: mlxsw: qos_mc_aware: Specify arping timeout as an integer
Date:   Thu, 28 May 2020 07:55:46 -0400
Message-Id: <20200528115600.1405808-33-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115600.1405808-1-sashal@kernel.org>
References: <20200528115600.1405808-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Amit Cohen <amitc@mellanox.com>

[ Upstream commit 46ca11177ed593f39d534f8d2c74ec5344e90c11 ]

Starting from iputils s20190709 (used in Fedora 31), arping does not
support timeout being specified as a decimal:

$ arping -c 1 -I swp1 -b 192.0.2.66 -q -w 0.1
arping: invalid argument: '0.1'

Previously, such timeouts were rounded to an integer.

Fix this by specifying the timeout as an integer.

Fixes: a5ee171d087e ("selftests: mlxsw: qos_mc_aware: Add a test for UC awareness")
Signed-off-by: Amit Cohen <amitc@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
index 24dd8ed48580..b025daea062d 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
@@ -300,7 +300,7 @@ test_uc_aware()
 	local i
 
 	for ((i = 0; i < attempts; ++i)); do
-		if $ARPING -c 1 -I $h1 -b 192.0.2.66 -q -w 0.1; then
+		if $ARPING -c 1 -I $h1 -b 192.0.2.66 -q -w 1; then
 			((passes++))
 		fi
 
-- 
2.25.1

