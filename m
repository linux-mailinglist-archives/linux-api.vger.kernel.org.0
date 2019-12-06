Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19958115786
	for <lists+linux-api@lfdr.de>; Fri,  6 Dec 2019 20:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfLFTF4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Dec 2019 14:05:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34169 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLFTF4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Dec 2019 14:05:56 -0500
Received: by mail-ot1-f66.google.com with SMTP id a15so6743429otf.1
        for <linux-api@vger.kernel.org>; Fri, 06 Dec 2019 11:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hzdm6u920Zu54Rz956W5+h57WY85ZdtVdfqXsUs3cp8=;
        b=J4JUk+kAi6AePh5EdVHtj8RlKN+OE+UFUQe7FYgJcHltk0WRhaTjkhwU0wmPbDnDYT
         FHN6EPvuf2yqeZgSsN2mcLncQnH+GKBoisvS0RTjO29r/4ZFHaMZW2oAcLb0fFQ9PCYR
         3/m6PxAtt0Myu+OkS0UtrNRV2TBUhDx4ZvrAh7GkEZMz0/Qw7KfWmOxsXZBTbTUzp5hu
         XWOXwZophPiJ/xN0LrLP0vbeWf5BM2qzWJERF76i7s+q0t0Uqe+aSoj6HoHpKxo8Rkvl
         avIcEBovZU9/+4BAogk9vMAJ31pOIUmps1j6aWPGKdaa79nyj3uXKg3DqUM7ZBfsm916
         yDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hzdm6u920Zu54Rz956W5+h57WY85ZdtVdfqXsUs3cp8=;
        b=dRf8F/p39ZVaDPa+Y5IuDU1Z5Cvas9mB3JsqBvTRSI0YXzwT2EC4tpZTaRbNNeMGRV
         lF8ltYeMkwbMphJe+uJquR9Qw8xZZnLMZOqoWFgg1sQtyOcBnhZenFfS+/FGb5tzUC4s
         Ci86hQ43fqSWujyL6ST22qbuECdmcSg/UuEyxN4LpGZlW8Y+XRMAbu+tvB3D2uqECAtt
         NKE+Fyq8WkeKX8nJ0sBz1+O4Lp+ErG1EjgmJK+CKlABGeT1uRIVUG88tv7llDgQFdoPZ
         Ka/XTgnUoiJc5R45jKLljXu5qjdIrQSdddnIdadJoyWsHfpdSMtI1yIGZcXf2idLgaPQ
         6kVA==
X-Gm-Message-State: APjAAAXU5t8n/Xwg1lHPNfNMYkgHWVd35MzoKuyI1nXJKavrL3yrbiJR
        ynfBibCdmXbf69eD6oyIvd7wJo7aImfalB4v9jNwug==
X-Google-Smtp-Source: APXvYqxBlAYMU2VRo65PaVig+MDoNvZGl/Bqu9L0uwzVZ+XAIRFSFEQftz1iNNNkf7nXZPvV1h2pHfuCiVPBh1GsvNg=
X-Received: by 2002:a9d:3b8:: with SMTP id f53mr12592920otf.180.1575659154739;
 Fri, 06 Dec 2019 11:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
 <20191206141045.GA22803@cisco> <CAMp4zn-Ni-nHrQgn34jV6gzanTiF+wxPrr_zqM47McZQ8TKa5w@mail.gmail.com>
In-Reply-To: <CAMp4zn-Ni-nHrQgn34jV6gzanTiF+wxPrr_zqM47McZQ8TKa5w@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 6 Dec 2019 20:05:28 +0100
Message-ID: <CAG48ez23UZYRytSNYd74pZuCXPXtOQjZeixP18CL0XZEz-NP0w@mail.gmail.com>
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GETFD request
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 6, 2019 at 8:03 PM Sargun Dhillon <sargun@sargun.me> wrote:
> On Fri, Dec 6, 2019 at 6:10 AM Tycho Andersen <tycho@tycho.ws> wrote:
> > On Thu, Dec 05, 2019 at 11:44:53PM +0000, Sargun Dhillon wrote:
> > > take action on an FD on behalf of the tracee. For example, this
> > > can be combined with seccomp's user notification feature to extract
> > > a file descriptor and call privileged syscalls, like binding
> > > a socket to a privileged port.
> >
> > This can already be accomplished via injecting parasite code like CRIU
> > does; adding a ptrace() command like this makes it much nicer to be
> > sure, but it is redundant.
> >
> How can you do this if the tracee doesn't have privilege? For example,
> if the tracee doesn't have CAP_SYS_BIND_SERVICE, how could you
> get it to bind to a port that's privileged without taking the file descriptor
> and doing it in a process that does have CAP_SYS_BIND_SERVICE?

(You can let the parasite send the fd to the tracer via
SCM_CREDENTIALS if you have previously set up a unix domain socket for
this.)
