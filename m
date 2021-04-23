Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B13368B52
	for <lists+linux-api@lfdr.de>; Fri, 23 Apr 2021 04:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhDWC57 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Apr 2021 22:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhDWC57 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Apr 2021 22:57:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C9BC06174A
        for <linux-api@vger.kernel.org>; Thu, 22 Apr 2021 19:57:24 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id j7so24831659pgi.3
        for <linux-api@vger.kernel.org>; Thu, 22 Apr 2021 19:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=arsdj8vKnkIONLNBcA7aqij2gyfUw/1l6TswIRx/eE4=;
        b=eXQfRFQnN2l37Rz03yVVNKTfVVWaEtnmnCBueTkCJYLwVSfwlr004PJ6fCbfI0cwtE
         dBsCscUZJdU2+UwOP0gRfKGO14+WjaToJlGk41YLfdasQvfmY3VbL1LvpKE4rBYNhxZh
         mpPP/78fHZw3MKVGAjLEZbeA/ol8zp/LO+oRGWxMbOeVPraD8VzMgI117jJW2jsQHiwz
         0nOzRqej7s5U2DAjBPFp1qw9t++5bOgiHRvkOqsiRJu7eFRYAMkuIPt4VLQHluU7RKPU
         Ip1ZclGanO2CLGZyAqSrPbFm9FrtftttqFwgpu9u75yuFGL5GuGkh4TNiUyFgI8ReH5K
         aZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=arsdj8vKnkIONLNBcA7aqij2gyfUw/1l6TswIRx/eE4=;
        b=GGJm+2GY+7T91DsFEtcyAhDd0ryjyvWJ/IbcgsM48WNzXOqcG72hob4A3cpjA4IG4e
         DROow+4UxxGQ5eZyZBa85N4/Vmmnnpvi/VwsAevRzgcys/tsuIyM8fU0Rg37PpWSWWqz
         l0EZ9s16ujDo1AAzHDCknGMeNxcHdZdPulZeas09fzDfxckqMFkNw8gvDJ62Uw/8zGOs
         l896LoO9kJfIeNQP7BqUPBlA+ZyR8qVbaMPUw9X76xCaDxmVVoBw0opc9DTkbzFqJoA4
         s2iLnCnD504tZiFs/7+x/WNIkCflCrNK6IMb+obDFoxl1cC3di0XoZ3R6jEmaEaMXLqx
         1t5g==
X-Gm-Message-State: AOAM530oVzYTy539XWAS5qngygd5ZxLljLtuo1VZcpo1VyAEWyog9+DJ
        pLCD/KmqmLWhE+Uqvb7t99e3dQ==
X-Google-Smtp-Source: ABdhPJzD1/uApxHDzfK9xvzlqGuD4OZV/7g8PoNIwhou7rOFWia/5lQuW5JSlqS+QRA4LREGC9ONkA==
X-Received: by 2002:a65:5888:: with SMTP id d8mr1634494pgu.23.1619146643509;
        Thu, 22 Apr 2021 19:57:23 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d4sm5796664pjz.49.2021.04.22.19.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 19:57:22 -0700 (PDT)
Date:   Thu, 22 Apr 2021 19:57:22 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 19:57:21 PDT (-0700)
Subject:     Re: [PATCH] riscv: Bump COMMAND_LINE_SIZE value to 1024
In-Reply-To: <alpine.DEB.2.21.2104022022300.18977@angie.orcam.me.uk>
CC:     david.abdurachmanov@gmail.com, dvyukov@google.com, alex@ghiti.fr,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-api@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     macro@orcam.me.uk
Message-ID: <mhng-9e6b4607-6bea-411c-b843-916c1e0798ee@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 02 Apr 2021 11:33:30 PDT (-0700), macro@orcam.me.uk wrote:
> On Fri, 2 Apr 2021, David Abdurachmanov wrote:
>
>> > > >  This macro is exported as a part of the user API so it must not depend on
>> > > > Kconfig.  Also changing it (rather than say adding COMMAND_LINE_SIZE_V2 or
>> > > > switching to an entirely new data object that has its dimension set in a
>> > > > different way) requires careful evaluation as external binaries have and
>> > > > will have the value it expands to compiled in, so it's a part of the ABI
>> > > > too.
>> > >
>> > > Thanks, I didn't realize this was part of the user BI.  In that case we
>> > > really can't chage it, so we'll have to sort out some other way do fix
>> > > whatever is going on.
>> > >
>> > > I've dropped this from fixes.
>> >
>> > Does increasing COMMAND_LINE_SIZE break user-space binaries? I would
>> > expect it to work the same way as adding new enum values, or adding
>> > fields at the end of versioned structs, etc.
>> > I would assume the old bootloaders/etc will only support up to the
>> > old, smaller max command line size, while the kernel will support
>> > larger command line size, which is fine.
>> > However, if something copies /proc/cmdline into a fixed-size buffer
>> > and expects that to work, that will break... that's quite unfortunate
>> > user-space code... is it what we afraid of?
>> >
>> > Alternatively, could expose the same COMMAND_LINE_SIZE, but internally
>> > support a larger command line?
>>
>> Looking at kernel commit history I see PowerPC switched from 512 to
>> 2048, and I don't see complaints about the ABI on the mailing list.
>>
>> If COMMAND_LINE_SIZE is used by user space applications and we
>> increase it there shouldn't be problems. I would expect things to
>> work, but just get truncated boot args? That is the application will
>> continue only to look at the initial 512 chars.
>
>  The macro is in an include/uapi header, so it's exported to the userland
> and a part of the user API.  I don't know what the consequences are for
> the RISC-V port specifically, but it has raised my attention, and I think
> it has to be investigated.
>
>  Perhaps it's OK to change it after all, but you'd have to go through
> known/potential users of this macro.  I guess there shouldn't be that many
> of them.
>
>  In any case it cannot depend on Kconfig, because the userland won't have
> access to the configuration, and then presumably wants to handle any and
> all.

It kind of feels to me like COMMAND_LINE_SIZE shouldn't have been part 
of the UABI to begin with.  I sent a patch to remove it from the 
asm-generic UABI, let's see if anyone knows of a reason it should be 
UABI:

https://lore.kernel.org/linux-arch/20210423025545.313965-1-palmer@dabbelt.com/T/#u
