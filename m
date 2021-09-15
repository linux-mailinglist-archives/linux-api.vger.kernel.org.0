Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D92140C736
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbhIOOTK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 10:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbhIOOTJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 10:19:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42931C061764;
        Wed, 15 Sep 2021 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bQi/c1b91PkaK1AxrCeWpy0hqeqegZIFrdVaK/kwyPM=; b=ocfZekIQPd26L2rGc0GsSdaWpF
        9bbsu5/KrHjuACm/QnHzxoAxsAKhuiLMFHwfeTos1px0epWiQi32XEjJKROQSS/zVLSEiAqvNKarn
        LD5g+oCNXYgyhzDQSw2ck5NafxnYjkSt9rSZN7ZkxcZDAlEX6Qqxadfv71nf0U7zOaazwy8LaeHBd
        jK4x4kBo3ZzflMiQriJuBE+TTL8Hg04t1KTYbQUybYhaEciYbNmMSSh4V/4v6077TgKBB11QTFZJ6
        +Ba15v9AQg50+ygXUH8Ks+EMhZghqOyK5sPjK1K1IALkCi+Snu7pNVKGPxDpgUMg2y6VrK5FylW2+
        gizFXXyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQVj8-003PTk-K8; Wed, 15 Sep 2021 14:17:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2399A30003A;
        Wed, 15 Sep 2021 16:17:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D8B1B20D149B0; Wed, 15 Sep 2021 16:17:28 +0200 (CEST)
Message-ID: <20210915140710.596174479@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 15 Sep 2021 16:07:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     andrealmeid@collabora.com, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, rostedt@goodmis.org, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, dave@stgolabs.net, arnd@arndb.de
Subject: [PATCH 00/20] futex: splitup and waitv syscall
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

Neither Thomas nor myself much liked that futex2.c nor do we think that CONFIG_
symbol makes much sense.

However, futex.c is a wee bit long and splitting it up makes sense. So I've
taken the liberty to replace your initial patch with 15 of my own and then
rebased the remaining patches on top of that.

Thomas, does something like this work for you?

