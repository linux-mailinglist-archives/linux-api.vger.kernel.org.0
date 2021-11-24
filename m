Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B9E45CFF7
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 23:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245314AbhKXWV4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Nov 2021 17:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243516AbhKXWVz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Nov 2021 17:21:55 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A007EC061574;
        Wed, 24 Nov 2021 14:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sEQB/jjB9aOv3YFUMqLZKs+O/a2g4X/PQogVeTcsvsE=; b=polHpjfVG8fg9i75kJGRg4xa8D
        CijPbahqUUi6seetXzDtp8n06kzPDiMnhB3GaUMGLd7kErl1PoTA+lccFZQ2hzTVbKAIlyZfkImN6
        95N4BlDXd2eMO/ra2dHy64j0Xn4RfSE67RfjHaROS7NfWxRxVYq4weKVDq2Hg4iV3HI1Ro8gXeGm8
        WmlWYt/lK0jexevqrdMUfaqQ62P83MhmMR+FtpTbA0ZIOW5okWYttXWLm3kdMAYw8Hx+3a51yfie6
        EAAicmCO0dfe7x2X34V/ETeS0yPHwR16+fg5U81qaC1Lj6vl4c4zoz4JBLfqe+6A+uG+F8coIQ4J+
        UC1vzoGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq0b3-000KIU-PD; Wed, 24 Nov 2021 22:18:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B7C4986843; Wed, 24 Nov 2021 23:18:33 +0100 (CET)
Date:   Wed, 24 Nov 2021 23:18:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <20211124221833.GJ721624@worktop.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122211327.5931-4-posk@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 22, 2021 at 01:13:24PM -0800, Peter Oskolkov wrote:
> +die:
> +	pr_warn("%s: killing task %d\n", __func__, current->pid);
> +	force_sig(SIGKILL);

That pr_warn() might need to be pr_warn_ratelimited() in order to no be
a system log DoS.

Because, AFAICT, you can craft userspace to trigger this arbitrarily
often, just spawn a worker and make it misbehave.

