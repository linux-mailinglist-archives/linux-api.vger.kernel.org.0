Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C49F032F
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 17:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390123AbfKEQl6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 11:41:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39672 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390156AbfKEQl6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 11:41:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id y3so22647145ljj.6
        for <linux-api@vger.kernel.org>; Tue, 05 Nov 2019 08:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPAWoJPOWFI9tZt+Z9WZhKGPSIvelnJJqs8XUy+V46k=;
        b=CbGKKPGgaC64y9p1BQq2+o8j3eZeZ9xzHn8JM0uVa/q2Dp+fcmnbfaSGvPUxtlWjOS
         ynZSdksFstX3dfMBSBg9tio5MZWnxRY6E7meZbkdx/z1h07ghzvK3IuvI1rXj14LMx+A
         3PsnudVi44KqkoSJSpfg66RMkDWNbjEBwkW8KDptiEdJzM5ryLb72MooGxElnni7OIKe
         zx9XJ0wui53vXA58fv5HWJnIk+ltmjQZ8JsgFM6ipJSqo7wifvmA4eEw1JObeYBkkXSH
         Ffb7hexTfsnPXuxAufhBpC0ii8o0VzIJ7yjyvhHtQ1CwosO8muSP1sgfcpjtqOgt3GeT
         8FuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPAWoJPOWFI9tZt+Z9WZhKGPSIvelnJJqs8XUy+V46k=;
        b=ieQHZAeYe9Hgxp099kEtsYez+NqG7B+Vcs5N5wvdc1z3n4fPnk+FPMKCY5aqSlVFph
         akb0k8XkW9NYHQfDvz/vOBaOWyKZhkdhJffnNp7akRpzCZjfRkObvQPKKkAhAd4mIqSy
         ErGgoRI4D948QU+0bOz225KVR9BP7STvTIuc1LimkL6QDFLBQOLn8eUvVWLB+ctzm0Z/
         BH4NmZLs5PRi6SRPej9bzA1awepyCyZB9r4RPuC7ZZn4jRqrUoOViBDVSvB/UHj1hK1A
         cosOfuoKfXyIyETd2y/Qbcyhpc3bGWNPdzyNbJ3XNGJLClCEU34GdNo3jfB+lSReo6zv
         IYmg==
X-Gm-Message-State: APjAAAVYl0HIksdEXpzBJAVgHo/kmU91z/bMi4BkAL30tGSNekLKli46
        Q6I68wYjU0VX57IyYqkGZoHnTuvQAQMCrM2HCRDf8w==
X-Google-Smtp-Source: APXvYqzJhVMjwxTvLIsbgfPh/CEzKCXdjh4ZL0tYyqLClkvm34sCnU8o9OP8Jjv4YmS1doxJFXVAsqkHWRlEyPnswzU=
X-Received: by 2002:a2e:3111:: with SMTP id x17mr23711544ljx.146.1572972114631;
 Tue, 05 Nov 2019 08:41:54 -0800 (PST)
MIME-Version: 1.0
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com> <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com> <20191105162424.GH30717@redhat.com>
In-Reply-To: <20191105162424.GH30717@redhat.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 5 Nov 2019 08:41:18 -0800
Message-ID: <CAKOZuet=g++G+biSP5bU-Rppu6fykU1TVUDj20NapqAYQY4r9A@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 5, 2019 at 8:24 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
> The long term plan is to introduce UFFD_FEATURE_EVENT_FORK2 feature
> flag that uses the ioctl to receive the child uffd, it'll consume more
> CPU, but it wouldn't require the PTRACE privilege anymore.

Why not just have callers retrieve FDs using recvmsg? This way, you
retrieve the message packet and the file descriptor at the same time
and you don't need any appreciable extra CPU use.
