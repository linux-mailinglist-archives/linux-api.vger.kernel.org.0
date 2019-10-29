Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAE1E8638
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 12:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfJ2LAZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 07:00:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34169 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfJ2LAZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Oct 2019 07:00:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id f5so10187793lfp.1
        for <linux-api@vger.kernel.org>; Tue, 29 Oct 2019 04:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NKg7u5dI/aetXjjN3SsmoQlpBiwrKqqloqLlWWxFfVQ=;
        b=MSsmJk7AsyIrbYG663mQnrA14v+NrqCOvnBRseZt2FopMZ9uTpUI1uOR5dR4fHu1gw
         FdmTJYosQ1xm+kJCwJkiAOO8nZx5j4QTGpymQYtbfTWCteuDsHYWDaCZl2pLc7vcRuSb
         c6Q9pbUd4WTNvpMp8/BvmIT1A7InVptd/VHSKmpDflICy8t1DrZzOz9/351E1JWbB3oo
         AtGltGjkkd67KkvekD5lyOpgdy17ZyO5fSmzF3cw8pldgoFFz0h3MKfuln6D/1IZvq86
         wdq2peV4QeI6PagkdlhXVpJyu/Jp0oOV6Xs9u62tAyHG4K/xHabybrybipUrHF09EOeR
         gJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NKg7u5dI/aetXjjN3SsmoQlpBiwrKqqloqLlWWxFfVQ=;
        b=kk5YPQivPrG/pggnbPKro7vjA20Eo7xLSUEPgpSLxvY58J6XT2Vy2NERZUrHUjMNg1
         YMvq6Ovh2fsm62+YlJJkKjacCZ8pTHBHUvR4Y2inG/lTKBHxdI3kXcCHbhlQLYfKHtxB
         gwCFGjV81jgD7rQFrtBJJ93mICQzIZM1J2qIhLAdhYU1SuZ1CfNWBRqxyXwo8p84lasp
         r3EooZnFNvzbe3W/32KPNSEBs0HYEdnH4JkII5aewnpT4i/+YdorKEClhp8bJV6aMRNg
         NyqG1vFITj3cjQrlw9JOpWm+pW6fGm9CJI6MPS58GoSKqVl6pqx18ebOrqQt5QYNSuYf
         Xsyg==
X-Gm-Message-State: APjAAAUV3Cvpp8P3m19R1Ttqup6EsenBHT3UILQHGvLC/W0skOpXxTbO
        SH+jxQpJrhWtWXgJtGx283Mr7Q==
X-Google-Smtp-Source: APXvYqwmI4WVp++wXBW/3hIg2fhQrc/nvc0g7ASX0cSTIRCEgK0Qc7IA/ofesxVbkFKz3qX07wnEHQ==
X-Received: by 2002:a19:e017:: with SMTP id x23mr2005378lfg.88.1572346823685;
        Tue, 29 Oct 2019 04:00:23 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q15sm5071450lfb.84.2019.10.29.04.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 04:00:22 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 73C11100240; Tue, 29 Oct 2019 14:00:24 +0300 (+03)
Date:   Tue, 29 Oct 2019 14:00:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191029110024.yjytp22lhd2vekrv@box>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx>
 <20191028131623.zwuwguhm4v4s5imh@box>
 <CAA9_cmd7f2y2AAT6646S=tco3yfyLgCAC4Qp=1iTQaJqrQcOwQ@mail.gmail.com>
 <20191029064318.s4n4gidlfjun3d47@box>
 <20191029085602.GI4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029085602.GI4114@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 29, 2019 at 09:56:02AM +0100, Peter Zijlstra wrote:
> On Tue, Oct 29, 2019 at 09:43:18AM +0300, Kirill A. Shutemov wrote:
> > But some CPUs don't like to have two TLB entries for the same memory with
> > different sizes at the same time. See for instance AMD erratum 383.
> > 
> > Getting it right would require making the range not present, flush TLB and
> > only then install huge page. That's what we do for userspace.
> > 
> > It will not fly for the direct mapping. There is no reasonable way to
> > exclude other CPU from accessing the range while it's not present (call
> > stop_machine()? :P). Moreover, the range may contain the code that doing
> > the collapse or data required for it...
> > 
> > BTW, looks like current __split_large_page() in pageattr.c is susceptible
> > to the errata. Maybe we can get away with the easy way...
> 
> As you write above, there is just no way we can have a (temporary) hole
> in the direct map.
> 
> We are careful about that other errata, and make sure both translations
> are identical wrt everything else.

It's not clear if it is enough to avoid the issue. "under a highly specific
and detailed set of conditions" is not very specific set of conditions :P

-- 
 Kirill A. Shutemov
