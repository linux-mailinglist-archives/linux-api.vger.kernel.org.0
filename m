Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8832F2574
	for <lists+linux-api@lfdr.de>; Tue, 12 Jan 2021 02:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbhALBWz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Jan 2021 20:22:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbhALBWy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 11 Jan 2021 20:22:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4FD122E02;
        Tue, 12 Jan 2021 01:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1610414534;
        bh=fLNQgllo3ZCC89DtTE5b6OoK2bTVUyylbTOPyId0eV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=obUs4N4o5mwnHVY9rYZZwXnXS8Rn/+2bqeLExSBNmLFsy9ruDGHnQziwu81t3OtpB
         PCgTuMFGUgwQ4wliyDaARt6hTTmnxw/q/pER+IErGNWBm56XeOCFS8usUIIULFFbFS
         agjczPAoQHs0WnCYRFSNbfsIqDiUY4VZ6Mq3u99c=
Date:   Mon, 11 Jan 2021 17:22:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     jannh@google.com, keescook@chromium.org, jeffv@google.com,
        minchan@kernel.org, mhocko@suse.com, shakeelb@google.com,
        rientjes@google.com, edgararriaga@google.com, timmurray@google.com,
        linux-mm@kvack.org, selinux@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement
 for process_madvise
Message-Id: <20210111172213.ab4185a1de916c35f3245021@linux-foundation.org>
In-Reply-To: <20210111170622.2613577-1-surenb@google.com>
References: <20210111170622.2613577-1-surenb@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 11 Jan 2021 09:06:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> process_madvise currently requires ptrace attach capability.
> PTRACE_MODE_ATTACH gives one process complete control over another
> process. It effectively removes the security boundary between the
> two processes (in one direction). Granting ptrace attach capability
> even to a system process is considered dangerous since it creates an
> attack surface. This severely limits the usage of this API.
> The operations process_madvise can perform do not affect the correctness
> of the operation of the target process; they only affect where the data
> is physically located (and therefore, how fast it can be accessed).
> What we want is the ability for one process to influence another process
> in order to optimize performance across the entire system while leaving
> the security boundary intact.
> Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> and CAP_SYS_NICE for influencing process performance.

It would be useful to see the proposed manpage update.

process_madvise() was released in 5.10, so this is a
non-backward-compatible change to a released kernel.

I think it would be OK at this stage to feed this into 5.10.x with a
cc:stable and suitable words in the changelog explaining why we're
doing this.

Alternatively we could retain PTRACE_MODE_ATTACH's behaviour and add
PTRACE_MODE_READ&CAP_SYS_NICE alongside that.
