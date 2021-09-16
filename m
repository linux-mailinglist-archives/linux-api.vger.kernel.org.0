Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D969440D865
	for <lists+linux-api@lfdr.de>; Thu, 16 Sep 2021 13:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbhIPLWK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Sep 2021 07:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbhIPLWJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Sep 2021 07:22:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BD1C061574;
        Thu, 16 Sep 2021 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lp3jA41szRIjlWUCunPenP0SdzHXeXCnjtYe6378xi8=; b=Xk8xSr2n7befaTE6LAeWcL1WqU
        Jz2BRHkjUR3wUBJa/OV//UW1r0A2nDmpzP2yOhPr723F0tjbuy8Zv5OPsum/2rtcUoEkecxqIqW2z
        NCUi5M7vBeLfQcV2Nioy2Kmu6LM3rijM2EBtw6GrWUunyI/8mNUdZWOPMOa6I8UtTmP+acMKB3Zcq
        8NrS4WlGo4WtaE+NuvV1Ao2RxsQM2u7EhaFTPr70aMAF5KOoRrOWy2T8B9JKvIOFzexsrQQV31Z73
        9bOzi2Bm21e2zAorqVvZLyrkSTMgdBkyLiDJtA5K1uEQ9LNsuQ6DgfoCYAGkAn3uqp+vILjUpD0f5
        9plkJwgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQpRQ-003daG-OA; Thu, 16 Sep 2021 11:20:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E90EA3000A3;
        Thu, 16 Sep 2021 13:20:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5AA62CE72553; Thu, 16 Sep 2021 13:20:30 +0200 (CEST)
Date:   Thu, 16 Sep 2021 13:20:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, mtk.manpages@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/6] futex2: Implement vectorized wait
Message-ID: <YUMofqnG6zE4BrnR@hirez.programming.kicks-ass.net>
References: <20210913175249.81074-1-andrealmeid@collabora.com>
 <20210913175249.81074-3-andrealmeid@collabora.com>
 <875yv4ge83.fsf@collabora.com>
 <58536544-e032-1954-ce30-d131869dc95e@collabora.com>
 <8735q5dutq.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735q5dutq.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 16, 2021 at 12:10:25AM -0400, Gabriel Krisman Bertazi wrote:

> I find this weird.  I'm not even juts talking about compat, but even on
> native 32-bit. But also, 32 applications on 64, which is a big use
> case for games.

Seriously, people still make 32bit applications today? And for legacy
games, I would think the speed increase of modern CPUs would far offset
this little inefficiency.
