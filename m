Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB7538C982
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 16:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhEUOvM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 10:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhEUOvM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 10:51:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B70C061574;
        Fri, 21 May 2021 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ALbn5lDFGLmOae7t1+VXfI4tB9A+uk2BFLNOfo90rDI=; b=MiZuaH47ebEV3px0iHZfjsGtUf
        fIa/bT8qo86+Xj/otzNB0/fs5q7hAb6rTtqxfDmq6/F33H0hGJZ2j3usmoNfnnLzRGhu03FRYOwuQ
        gR43d+PdjVqSRd9RgEb83MnvBtxMJrbbmGh1qlFsABzu97ilJaT/zXLcr2VUmn7MaacykgrNkYqvF
        UQNvLKqV/PY10mXk6dbXBsM9e9bWBGiHrhjNK3TUyJ6NTWpXEXA9GCapn7+tWQcEWdNBMy1M142Mw
        ekBF+739VztnZU5vUMgMknt3CxcDhWbmM5NSDwdnKu9IBWXMXhl9pdYEqRiogc/QZFGl8pszLgPcZ
        IyqRTeYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lk6Sp-005pTi-NA; Fri, 21 May 2021 14:49:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F0CE300264;
        Fri, 21 May 2021 16:49:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F28F30D9D883; Fri, 21 May 2021 16:49:22 +0200 (CEST)
Date:   Fri, 21 May 2021 16:49:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>,
        Len Brown <lenb@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Rich Felker <dalias@libc.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <YKfIct+DhpEBbaCQ@hirez.programming.kicks-ass.net>
References: <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic>
 <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de>
 <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
 <87k0ntazyn.ffs@nanos.tec.linutronix.de>
 <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
 <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
 <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com>
 <87pmxk87th.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmxk87th.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 21, 2021 at 04:44:58PM +0200, Florian Weimer wrote:

> And we added an interface for querying x86 CPU features to glibc 2.33
> which is completely incompatible with this because it assumes that CPU
> features do not change during the lifetime of a process. 8-(

How many x86 kernel maintainers signed off on that patch?
