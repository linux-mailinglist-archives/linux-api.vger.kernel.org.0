Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DD421E61B
	for <lists+linux-api@lfdr.de>; Tue, 14 Jul 2020 05:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgGNDEF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jul 2020 23:04:05 -0400
Received: from mail.efficios.com ([167.114.26.124]:46260 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGNDD7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jul 2020 23:03:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A281A2B872A;
        Mon, 13 Jul 2020 23:03:58 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6zycexgbCCq0; Mon, 13 Jul 2020 23:03:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 562662B8723;
        Mon, 13 Jul 2020 23:03:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 562662B8723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594695836;
        bh=bjDVGCYinA7mDg3vt2mL+W4CWdvaNqgru/04cAlga9E=;
        h=From:To:Date:Message-Id;
        b=V7i9rZhJ4o67XgSHyIl8aU1aHfY9afjcVVKMUOrWHgw/hnMJ3SqqfrYzrlVab07+b
         sQkxorKUNFS8RGEZKE9A9GEIHDszoACKhkHJ3A/dnHQwGdx90jmfHDR5XKruHHgznH
         bqONtJasNfoEAwuhjSg8r3/reulCApe0YH7EfLtjaagQodTjFCV8qX3AvlCNFqY05K
         Hc2T3vkOH34EX7zI4omV7OdOdWN2tddKWEXDPf5072bcoHyG6Z9wRFz/0L4vtn/NS3
         inT3k1b9rUi7EM6YiDRO5QlfctcSlU7o7amIPhezD2tv9HUc+clatgiOWL8NS6ZWpq
         9FQJju9fD5xTw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C-7aZC6kzWqn; Mon, 13 Jul 2020 23:03:56 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 9DE3F2B888D;
        Mon, 13 Jul 2020 23:03:55 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, carlos@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 3/4] selftests: rseq: define __rseq_abi with extensible size
Date:   Mon, 13 Jul 2020 23:03:47 -0400
Message-Id: <20200714030348.6214-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Define the __rseq_abi with the extensible size feature.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index da2264c679b9..2c29215d4790 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -26,6 +26,7 @@
 #include <assert.h>
 #include <signal.h>
 #include <limits.h>
+#include <stddef.h>
 
 #include "rseq.h"
 
@@ -33,6 +34,8 @@
 
 __thread volatile struct rseq __rseq_abi = {
 	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
+	.flags = RSEQ_TLS_FLAG_SIZE,
+	.user_size = offsetof(struct rseq, end),
 };
 
 /*
-- 
2.17.1

