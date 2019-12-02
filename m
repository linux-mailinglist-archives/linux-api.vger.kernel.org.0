Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12BBD10F36D
	for <lists+linux-api@lfdr.de>; Tue,  3 Dec 2019 00:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLBXcF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Dec 2019 18:32:05 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:45332 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLBXcF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Dec 2019 18:32:05 -0500
Received: by mail-il1-f171.google.com with SMTP id o18so1338580ils.12
        for <linux-api@vger.kernel.org>; Mon, 02 Dec 2019 15:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9uAB7m6EBm7LH64uHm2P7qulgR/Phd5SEpXDcC0NfW4=;
        b=jD/nU9ncUTwABnL9cTtzqnxSLUjC7YR759S+8tWe/okFP/D12PdGUwTvNU9uYlIXcH
         L6otTPfAEHHPGWLd8mw7XEGIqpNQ3VkS7ZY3Leh4YyQctEkl6qvEQxrJ8IrAvB6PUt19
         aPcZOq6DVh8oxRV6hBlzabvEc6xKkGs7kltifvV0kTGT04O5Pr/0XTGqzZ25B//aZ19+
         9RebPbmAgdZPWWeCMzJHaHB6tLo8pvqppZKPtz/ftwlVSwEW2eqqo24Fioox4AgfRWNi
         BAL/6FegSca45vWq/G1BTfMZC2RhidA9Dh9EF8EQfc4KpQs/SEvY0ArYIzdiP8YsFpy7
         nKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uAB7m6EBm7LH64uHm2P7qulgR/Phd5SEpXDcC0NfW4=;
        b=T4ZbpysMfhSPFbh/sIGaDxaqylfIq5wd4jKTheo9q9eZmtOjddah81XKhM55pFoMN6
         zhIGHx+OB8HNXsKQ+IF6C1qTn9SsYIyGLftHtabAvFAqi7vnkGnPeQJs3KIHQLt7MofE
         oyFPcnBpUqgXPIEbXXM6AaWS3PUmpMBtn6i6EtOZmp7XGPlwEogshEmP+ED808EEFXuH
         YlRIAW2ip4SExfRKMqXIgxi+VTJwCh1GOp/7vqBrOWuo6UoAStsvbHuthbYMYaLGQV2Q
         IyucPVNNncvuOOtfbMO8RrkiQJjMngCBcy1yPwHjcDUbi4AjFYQCg4ohDNqobOAdIg9s
         r95A==
X-Gm-Message-State: APjAAAWUfRPUiHVv2LunG665MmWKo+QoiKRUWmw265n7kCYbpJeX3Mrn
        NPtTp/lYpLfKZCzsznjiQfwWya8mGHtIV8Bxr9dw+g==
X-Google-Smtp-Source: APXvYqyLlTHofgFEQJhW4sBHggg6gotb/5nppYVFMmmnwhNpyhS7sIPgk3giMxcH8j3bX2qFXiDG62Cf/6/RBwHxm5g=
X-Received: by 2002:a92:d744:: with SMTP id e4mr1763696ilq.64.1575329523952;
 Mon, 02 Dec 2019 15:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20191101210803.GA9841@xps13.dannf>
In-Reply-To: <20191101210803.GA9841@xps13.dannf>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 2 Dec 2019 15:31:52 -0800
Message-ID: <CACdnJuuXBQ__Sb8=V7CTZfXH=5LfbiU9SmUKapJov3Cd+aHQcw@mail.gmail.com>
Subject: Re: tracefs splats in lockdown=confidentiality mode
To:     dann frazier <dann.frazier@canonical.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        James Morris <jmorris@namei.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 1, 2019 at 2:08 PM dann frazier <dann.frazier@canonical.com> wrote:

> [    1.763630] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7

This is expected.

> [    2.913934] ------------[ cut here ]------------
> [    2.918435] Could not register function stat for cpu 0
> [    2.923717] WARNING: CPU: 1 PID: 1 at kernel/trace/ftrace.c:987 ftrace_init_tracefs_toplevel+0x168/0x1bc

This is not. I'll look into it.
