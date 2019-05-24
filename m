Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392522979A
	for <lists+linux-api@lfdr.de>; Fri, 24 May 2019 13:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391112AbfEXLwl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 May 2019 07:52:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37778 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391204AbfEXLwl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 May 2019 07:52:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so14002121edw.4
        for <linux-api@vger.kernel.org>; Fri, 24 May 2019 04:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ByWnRi5xnahJzCvKHvwWbU8X9Zsko8eu1QbpfSkepcI=;
        b=fj/ve63SAS6LbkLj3/2xSc53dNUmA1kW4LO4gSD8p2pPsVcJ9mLN+PvcWiX5chYCXi
         FwvB06ka0Un2UzcVw5StRa2fV3jOhanfDBaa2eLmuewTaYIk8Nyh2G/FBud9KdNKUPgD
         BnxdtzszrHmfqrRG6uZekWuGnfjzPJrl4G2hrnGkkSsXmhH/cL5dq4U7IQYqfuSQUa9q
         RoO0oAnWL3q712yci1RgE/ECkQYR0eHQ7n277ogD1Y/aDZ4+t4XeirJcK65N2OuHolOa
         gtM+Nl6z8WIZHPK/9i/SanpcCLzXIlgQ3an9r/HSECyPuRkRdPMF5GypCCnheChJ6uIc
         +cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ByWnRi5xnahJzCvKHvwWbU8X9Zsko8eu1QbpfSkepcI=;
        b=rrwI8JdQxjUOO7OGIb95RE58HTY2HNu5Y1VtXE3HHOB7Oovc5Tce8bcs8vZ9od7Mrm
         uoIvH8bbUpc5Jpg/qLQ55puA8kZOTV/SGfaGRcG5oR7ADc6kL0RvOwmC4yaJPgvjAAIE
         ZLKVc84uo5xvqya3jgi9CNWa3PuxdybWoN23k4Lrtd7SRfXNP4TqBss7dyZxiaIGhGn7
         6n+QZjbSO2EBjsZ9loa7fqUzf1OhZnhSkRPKuqlj+bSbbi2Z6jUwZZjtCgzbxIXRp3j6
         Ui0eINg35rEIcpX8tbd7j84zeOA49R4Pt5WFffv6g62KXD2XO3OWOGFt4ZCDl8EpOlcF
         jDMA==
X-Gm-Message-State: APjAAAUSDAq7LyFPejUMdzq3+e4EGIQrqQ9Hx9Cs8nOg/gFKiULhXM1N
        sSqpHjV2U4iWAyL4zM+vzFLbEA==
X-Google-Smtp-Source: APXvYqy+YBb8phwRTTasGpoCAhen7qTO3dYqvPQ/V2KcTvAargF0eTRh095ZIIytNdKz6fMRQTOaDg==
X-Received: by 2002:a17:906:2447:: with SMTP id a7mr1078163ejb.235.1558698759336;
        Fri, 24 May 2019 04:52:39 -0700 (PDT)
Received: from box.localdomain (mm-192-235-121-178.mgts.dynamic.pppoe.byfly.by. [178.121.235.192])
        by smtp.gmail.com with ESMTPSA id l19sm683637edc.84.2019.05.24.04.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:52:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1BED8102F25; Fri, 24 May 2019 14:52:39 +0300 (+03)
Date:   Fri, 24 May 2019 14:52:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, alexander.h.duyck@linux.intel.com,
        ira.weiny@intel.com, andreyknvl@google.com, arunks@codeaurora.org,
        vbabka@suse.cz, cl@linux.com, riel@surriel.com,
        keescook@chromium.org, hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        jannh@google.com, kilobyte@angband.pl, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/7] mm: process_vm_mmap() -- syscall for duplication
 a process mapping
Message-ID: <20190524115239.ugxv766doolc6nsc@box>
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
 <20190522152254.5cyxhjizuwuojlix@box>
 <358bb95e-0dca-6a82-db39-83c0cf09a06c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <358bb95e-0dca-6a82-db39-83c0cf09a06c@virtuozzo.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 24, 2019 at 01:45:50PM +0300, Kirill Tkhai wrote:
> On 22.05.2019 18:22, Kirill A. Shutemov wrote:
> > On Mon, May 20, 2019 at 05:00:01PM +0300, Kirill Tkhai wrote:
> >> This patchset adds a new syscall, which makes possible
> >> to clone a VMA from a process to current process.
> >> The syscall supplements the functionality provided
> >> by process_vm_writev() and process_vm_readv() syscalls,
> >> and it may be useful in many situation.
> > 
> > Kirill, could you explain how the change affects rmap and how it is safe.
> > 
> > My concern is that the patchset allows to map the same page multiple times
> > within one process or even map page allocated by child to the parrent.
> > 
> > It was not allowed before.
> > 
> > In the best case it makes reasoning about rmap substantially more difficult.
> > 
> > But I'm worry it will introduce hard-to-debug bugs, like described in
> > https://lwn.net/Articles/383162/.
> 
> Andy suggested to unmap PTEs from source page table, and this make the single
> page never be mapped in the same process twice. This is OK for my use case,
> and here we will just do a small step "allow to inherit VMA by a child process",
> which we didn't have before this. If someone still needs to continue the work
> to allow the same page be mapped twice in a single process in the future, this
> person will have a supported basis we do in this small step. I believe, someone
> like debugger may want to have this to make a fast snapshot of a process private
> memory (when the task is stopped for a small time to get its memory). But for
> me remapping is enough at the moment.
> 
> What do you think about this?

I don't think that unmapping alone will do. Consider the following
scenario:

1. Task A creates and populates the mapping.
2. Task A forks. We have now Task B mapping the same pages, but
write-protected.
3. Task B calls process_vm_mmap() and passes the mapping to the parent.

After this Task A will have the same anon pages mapped twice.

One possible way out would be to force CoW on all pages in the mapping,
before passing the mapping to the new process.

Thanks,
Kirill.
