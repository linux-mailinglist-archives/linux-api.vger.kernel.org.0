Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3340C85F
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 17:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbhIOPj0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 11:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbhIOPj0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 11:39:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB7FC061574;
        Wed, 15 Sep 2021 08:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=my5GhDl9/XfKpmw0KmGJa95nBwjwsu3UtxUJArbSNII=; b=U4bU/slaNoXy01+dToghzpYMqQ
        vd9MHsbyzYWmjx+LTrXUQ9T7PG3AeXXJa7LMUEpkElEBtepi+1mlqLk2cu7X5spgcsamiZvuKp+wJ
        XJC7QXYSMaEj5E/Ob+TB3wNPcH8H0MPGGPaEWq45v8WjuZSCLiu9n4jlWCgKdNA7nbRmStuvw5laz
        W3zjpx9EnIg0R2c0vSRl9s+yjD4HpGrZzLkwHODXo6ze+hzvGGeG8TZUIVGDcSwro/wGSm7tYFbAw
        W6KFSTswah5QN2ePjjBgDrxBtDkNUz4mfQGp12JHRi2l5akSttz9qPV7wazb4PEiXzmEvA5PlaDwZ
        SvNNWqHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQWyw-003QPg-E8; Wed, 15 Sep 2021 15:37:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E88C3001C7;
        Wed, 15 Sep 2021 17:37:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F69129BBD807; Wed, 15 Sep 2021 17:37:53 +0200 (CEST)
Date:   Wed, 15 Sep 2021 17:37:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     andrealmeid@collabora.com, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, rostedt@goodmis.org, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, mtk.manpages@gmail.com,
        dave@stgolabs.net, arnd@arndb.de
Subject: Re: [PATCH 16/20] futex: Implement sys_futex_waitv()
Message-ID: <YUITUXbnzAK98DEl@hirez.programming.kicks-ass.net>
References: <20210915140710.596174479@infradead.org>
 <20210915141525.621568509@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915141525.621568509@infradead.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 15, 2021 at 04:07:26PM +0200, Peter Zijlstra wrote:
> +SYSCALL_DEFINE4(futex_waitv, struct futex_waitv __user *, waiters,
> +		unsigned int, nr_futexes, unsigned int, flags,
> +		struct __kernel_timespec __user *, timo)

So I utterly detest timespec.. it makes no sense what so ever.

Can't we just, for new syscalls, simply use a s64 nsec argument and call
it a day?

Thomas, Arnd ?
