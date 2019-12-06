Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293A6115782
	for <lists+linux-api@lfdr.de>; Fri,  6 Dec 2019 20:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfLFTDq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Dec 2019 14:03:46 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41092 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfLFTDq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Dec 2019 14:03:46 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so6749923eds.8
        for <linux-api@vger.kernel.org>; Fri, 06 Dec 2019 11:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qle8HQCKp8iB748eskGQ1F5HxXTsSVTwYA22debS+8w=;
        b=mf5bYICDKaMoHy8wLugXaJp350E9QJj4mv65iPLyOk4pSMMxjTHjp58SUT2+L9j35b
         f6doCSuFcpzmlE/MbWx46qBJrxDupZEjtQ1Z5reg2oc4ywdjPrQU6nTHupEjmXeFN6KS
         pWTO5rJZ5uInYjdrebnbnMD++rsy1y46KvVvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qle8HQCKp8iB748eskGQ1F5HxXTsSVTwYA22debS+8w=;
        b=JJpkoPnnC9xOMCpHNbPfuVrE6RJ2BWGywXyBKysFsk8nlv75iCxIiUEVukOrjV9T5A
         Qgf1DFx415YTHygZ0j81WuhTTOgxagOWWkc4B8MAOAgIs4++HFumoiZ7ynXl87UZoCZ/
         lcsYCO2lvfZsP8CiCtN+nvUVao/VEX7F8aZY/09Pcj9PQvuxulZhKox7aa8d2lyhZzjf
         Eb0pLVQa3nDBAkKBg/Wq7uIdFDJ5IuXKTRTzmK5lAbguMEJ+k5/N6zV/cdWoGAiP2k2H
         bYHN2VarFyKFCyQgC6Ka3rwqCRw7B9KkAX4mRManIUaG8V9AnJoEmURNTLdDUb7inLEH
         lBZA==
X-Gm-Message-State: APjAAAVZQuXSJZa07Xq7NO/WucENc6PrUZxekCQ610PyGPCFIM5AbuCJ
        GEmugLNWXxZCQU5gNLvvao7s1MoUNOoSOvcHQkzsmg==
X-Google-Smtp-Source: APXvYqwAklgx+URXW5FsC1F/7JTwEA2XGuHuiqWye18cFsXfKd1gCrhcutl7X2035HC/qG3wgPVI3HqSN02dF8CLpTg=
X-Received: by 2002:a05:6402:1841:: with SMTP id v1mr18072982edy.290.1575659024113;
 Fri, 06 Dec 2019 11:03:44 -0800 (PST)
MIME-Version: 1.0
References: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal> <20191206141045.GA22803@cisco>
In-Reply-To: <20191206141045.GA22803@cisco>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Fri, 6 Dec 2019 11:03:08 -0800
Message-ID: <CAMp4zn-Ni-nHrQgn34jV6gzanTiF+wxPrr_zqM47McZQ8TKa5w@mail.gmail.com>
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GETFD request
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 6, 2019 at 6:10 AM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Thu, Dec 05, 2019 at 11:44:53PM +0000, Sargun Dhillon wrote:
> > PTRACE_GETFD is a generic ptrace API that allows the tracer to
> > get file descriptors from the traceee.
> >
> > The primary reason to use this syscall is to allow sandboxers to
>
> I might change this to "one motivation to use this ptrace command",
> because I'm sure people will invent other crazy uses soon after it's
> added :)
>
Another use-case that's come up has been transparent proxy for
service meshes. Rather than doing intercept at L4 (iptables), or
DNS, just rewriting the connect is nicer. A side benefit is that
getpeername still works.

> > take action on an FD on behalf of the tracee. For example, this
> > can be combined with seccomp's user notification feature to extract
> > a file descriptor and call privileged syscalls, like binding
> > a socket to a privileged port.
>
> This can already be accomplished via injecting parasite code like CRIU
> does; adding a ptrace() command like this makes it much nicer to be
> sure, but it is redundant.
>
> Tycho
How can you do this if the tracee doesn't have privilege? For example,
if the tracee doesn't have CAP_SYS_BIND_SERVICE, how could you
get it to bind to a port that's privileged without taking the file descriptor
and doing it in a process that does have CAP_SYS_BIND_SERVICE?

The other aspect is that doing the parasitic code thing is kind of slow,
in that it requires quite a few operations.
