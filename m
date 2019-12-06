Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5A211520D
	for <lists+linux-api@lfdr.de>; Fri,  6 Dec 2019 15:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfLFOKq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Dec 2019 09:10:46 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:34323 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfLFOKq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Dec 2019 09:10:46 -0500
Received: by mail-il1-f193.google.com with SMTP id w13so6373242ilo.1
        for <linux-api@vger.kernel.org>; Fri, 06 Dec 2019 06:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1YCWj4FzeVMFw7aPkv0f3vTJdk6KStMPvm4QDDtRoKw=;
        b=wVsQlnEEP00IyLn0NxUfNYmgRpx08qlKit0M/qQKRFSZCiM/zugpkeZ7s3lWRpScqh
         j/3zA/S7huJHRyimHxTic6SikWnjV0zzDpxEnJTrAlWNsSZDTP2xKPou2MfQ83sdMPac
         vZPtpi4C2KmJNlaiblnd2JEh0hAaC7vEqrXM0KT6a3OVQCFAlMDEJCZz1f4Bsx2GX8pB
         //kWW+qa2xxBradAYr7rtqBRrvCvsEgMVz7aGaZSa+q3an17+hnpKfJ2xhutdlxKzV/n
         Y6rJynf/nqEznj7mqAKGZrB06A+IwIq+o/JqLgdnrF2IjQsgIvMeWoLxjn+uzSO2JeM1
         C7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1YCWj4FzeVMFw7aPkv0f3vTJdk6KStMPvm4QDDtRoKw=;
        b=LMw4n18M35xom8ZeQRsV58FwuB0xO5r+IyhPaOq2cO79ioMOnrod31Gtv6kAdhmr/C
         fG/AstWRDdkTIyMiETHyhE765OQZJmA5LB9Ska2cSQSnU7WZoh66oz2XE/gN1EIOjAaq
         bG+N+AlnS2U0CgsSuWQb/LQKHbuvv0sSOw0WtHggVVZ+xMPMF5AItDzQfzR8v3/T0pdW
         vtnjt74+F6FIS7qTPp9nczITk3NBtqdkiWb35Qjj6jdi+JuZqevXMoLtZ4ee9+Zy9W1P
         XbHyIEDMlbLKPuYGRxNzBEzjnwuVfbEEBB3/h8Xh3crD16sxHZv2TfBmFVYu41GgJPNi
         hMJA==
X-Gm-Message-State: APjAAAXiRRGarUSFCXJH1jAPAZ5WeKNrne/2s+TajV5+mgH8t17m1HiP
        6nEsJ5dNzMOw1Bakqvrr4f2N1g==
X-Google-Smtp-Source: APXvYqxsa/txcRrIVZx26A+Ibxru94YoeqcnDJg06Ubl7ybKXXw+jIXNv8C+cTh9ikFkRi1dOjEDOw==
X-Received: by 2002:a92:4010:: with SMTP id n16mr15082339ila.260.1575641445120;
        Fri, 06 Dec 2019 06:10:45 -0800 (PST)
Received: from cisco ([2601:282:902:b340:45e0:b82b:a61a:f45])
        by smtp.gmail.com with ESMTPSA id e73sm3174303iof.63.2019.12.06.06.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:10:44 -0800 (PST)
Date:   Fri, 6 Dec 2019 07:10:45 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GETFD request
Message-ID: <20191206141045.GA22803@cisco>
References: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Dec 05, 2019 at 11:44:53PM +0000, Sargun Dhillon wrote:
> PTRACE_GETFD is a generic ptrace API that allows the tracer to
> get file descriptors from the traceee.
> 
> The primary reason to use this syscall is to allow sandboxers to

I might change this to "one motivation to use this ptrace command",
because I'm sure people will invent other crazy uses soon after it's
added :)

> take action on an FD on behalf of the tracee. For example, this
> can be combined with seccomp's user notification feature to extract
> a file descriptor and call privileged syscalls, like binding
> a socket to a privileged port.

This can already be accomplished via injecting parasite code like CRIU
does; adding a ptrace() command like this makes it much nicer to be
sure, but it is redundant.

Tycho
