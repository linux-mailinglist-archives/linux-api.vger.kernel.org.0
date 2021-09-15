Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D27340C835
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 17:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbhIOPYE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 11:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbhIOPYD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 11:24:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BFEC061766;
        Wed, 15 Sep 2021 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=w+4HUOseYLWQOhOIfvlspfwKzpzFtOuZKt8mbuvQ9Fw=; b=ASKb4E8MLht/7X//UjyozFI/wi
        L+hkkV04D2bfopjwXnvMTOkZC6FJFK7W8nZH9PXMql4yIPrHsXS7skhJug4fqZI9Xw8ugYabpBfdm
        cei4uWvrQ9nhQ5daR24Y/HM5eWHbzAHNqPrE/IqIGdppoUUpUmFn3xT03RN0/apFnCnA7ExPD8jSr
        59DadUhOkGORHIerpeooHhgMwJ+m4H7QrfDDmCU9k4lyJhuU7zQcm/i6hOUpHT8dZs2VBzXfzlB7m
        WvaN9z/lBe/FiqAVjcUMoSlHzAAI67LatZ/6slnYgYBW/32h9k8fUYAXJd2YCz+XHlWYdsIrkbB8H
        XsV55RhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQWk2-003QEL-1C; Wed, 15 Sep 2021 15:22:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F8D930003A;
        Wed, 15 Sep 2021 17:22:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D8B728B2ADDF; Wed, 15 Sep 2021 17:22:29 +0200 (CEST)
Date:   Wed, 15 Sep 2021 17:22:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        kernel@collabora.com, krisman@collabora.com, dvhart@infradead.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, dave@stgolabs.net, arnd@arndb.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
Subject: Re: [PATCH 07/20] futex: Rename hash_futex()
Message-ID: <YUIPtTHSW3SMKyU7@hirez.programming.kicks-ass.net>
References: <20210915140710.596174479@infradead.org>
 <20210915141525.047819744@infradead.org>
 <b1242a18-8f72-9005-1630-3a45297e95b5@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1242a18-8f72-9005-1630-3a45297e95b5@collabora.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 15, 2021 at 12:17:21PM -0300, André Almeida wrote:
> Às 11:07 de 15/09/21, Peter Zijlstra escreveu:
> > In order to prepare introducing these symbols into the global
> > namespace; rename:
> > 
> >   s/hash_futex/hash_futex/g
> > 
> 
> I think you meant
> 
>    s/hash_futex/futex_hash/g

I think so too :-) Clearly typing i hard...
