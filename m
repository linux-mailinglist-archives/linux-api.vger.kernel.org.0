Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E8122BF04
	for <lists+linux-api@lfdr.de>; Fri, 24 Jul 2020 09:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGXHZU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Jul 2020 03:25:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38644 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726703AbgGXHZT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Jul 2020 03:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595575518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fuErLOqr2wiHuSm1n+glJqJxYG3jv4lWg3NgZEQOlPE=;
        b=fPQU5YAOHeVpb/XBWql+enb3J1xB5CBDy8DczdAQ4HtDXLrq8hROvvEqGYJd8krSqb0GtK
        6Bisi/7F3+nHql9oAOKzUp6l1c61KzJQ03Vxaod6kWTUW2DuihfXEcd+huwbjRLhTEtY1F
        EubOu984psNZZTE6mSmraAEp0snG5Mk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-pc1DH_lmPcaocdZq0qLSqw-1; Fri, 24 Jul 2020 03:25:16 -0400
X-MC-Unique: pc1DH_lmPcaocdZq0qLSqw-1
Received: by mail-wr1-f69.google.com with SMTP id y18so1900158wrq.4
        for <linux-api@vger.kernel.org>; Fri, 24 Jul 2020 00:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fuErLOqr2wiHuSm1n+glJqJxYG3jv4lWg3NgZEQOlPE=;
        b=Z6dJZSn09f5w1QahirO5pf2DEkRYmTSVJ51bg5rGaTOxeXM7OE+n0WWS8nEVVOXnmV
         jBAW4LjvepNIPsXeoiBbDW7oV+AR9vMeYwiH5mf3dDF1ieTyOjEtaQvr6n/aOxUnC7k8
         U8Swi2cZilIjGscRtJ8sd+Pku1F1uL0mmJyuIcpYHxGn32z82/RpPeyjevuihjLuYokR
         WJuctUsmGymB3LFXE5f/WfsV6oAkjWSK/AAUttadePmvRF2t/M3DMMz7DulRhflyjoCH
         JB8SNfb66l/pEqCaJQb9NDZFAYQBp5D1P1DjD5dAL/enPLopP1mOFiioAssvIxxb9mcr
         1xgQ==
X-Gm-Message-State: AOAM5321yhkyYh1iXnUzM2Mxl5/kDVRWvJikdWdXIFcvedNynl1pvwfj
        6ojVFO5j4D5/htt0coJcJTC7UG6yj0pPHZ0wIZpzxvtMi98znA8svSW8fhs0Iv31Zg5zjqIQJbT
        38KsNOZexdqLvF558Z9UM
X-Received: by 2002:adf:bb52:: with SMTP id x18mr7081705wrg.325.1595575515196;
        Fri, 24 Jul 2020 00:25:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjC5TNOMsbWloWKiM1fPLp95PjAuhLTb70ke99fpxMRmPpCdyrTQ/Uxi1NsfB0ImOP4RPRkA==
X-Received: by 2002:adf:bb52:: with SMTP id x18mr7081693wrg.325.1595575514967;
        Fri, 24 Jul 2020 00:25:14 -0700 (PDT)
Received: from steredhat.lan ([5.171.199.112])
        by smtp.gmail.com with ESMTPSA id p25sm5864195wmg.39.2020.07.24.00.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 00:25:14 -0700 (PDT)
Date:   Fri, 24 Jul 2020 09:25:09 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Colin Walters <walters@verbum.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        strace-devel@lists.strace.io, io-uring@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: strace of io_uring events?
Message-ID: <20200724072509.sgqlbuocpo2peian@steredhat.lan>
References: <7c09f6af-653f-db3f-2378-02dca2bc07f7@gmail.com>
 <CAJfpegt9=p4uo5U2GXqc-rwqOESzZCWAkGMRTY1r8H6fuXx96g@mail.gmail.com>
 <48cc7eea-5b28-a584-a66c-4eed3fac5e76@gmail.com>
 <202007151511.2AA7718@keescook>
 <20200716131404.bnzsaarooumrp3kx@steredhat>
 <202007160751.ED56C55@keescook>
 <20200717080157.ezxapv7pscbqykhl@steredhat.lan>
 <CALCETrXSPdiVCgh3h=q7w9RyiKnp-=8jOHoFHX=an0cWqK7bzQ@mail.gmail.com>
 <20200721155848.32xtze5ntvcmjv63@steredhat>
 <d57e169a-55a0-4fa2-a7f2-9a462a786a38@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d57e169a-55a0-4fa2-a7f2-9a462a786a38@www.fastmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 23, 2020 at 09:37:40AM -0400, Colin Walters wrote:
> On Tue, Jul 21, 2020, at 11:58 AM, Stefano Garzarella wrote:
> 
> > my use case concerns virtualization. The idea, that I described in the
> > proposal of io-uring restrictions [1], is to share io_uring CQ and SQ queues
> > with a guest VM for block operations.
> 
> Virtualization being a strong security barrier is in eternal conflict
> with maximizing performance.  All of these "let's add a special
> guest/host channel" are high risk areas.
> 
> And this effort in particular - is it *really* worth it to expose a
> brand new, fast moving Linux kernel interface (that probably hasn't
> been fuzzed as much as it needs to be) to virtual machines?
> 

It is an experiment to explore the potential of io_uring. In addition
the restrictions can also be useful for other use case, for example if
a process  wants to allow another process to use io_uring, but only allowing
a subset of operations.

> People who want maximum performance at the cost of a bit of security
> already have the choice to use Linux containers, where they can use
> io_uring natively.
> 

Thanks,
Stefano

