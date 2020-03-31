Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82DC7199DFB
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2020 20:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCaS05 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 31 Mar 2020 14:26:57 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54419 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgCaS04 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 31 Mar 2020 14:26:56 -0400
Received: by mail-pj1-f66.google.com with SMTP id np9so1424669pjb.4
        for <linux-api@vger.kernel.org>; Tue, 31 Mar 2020 11:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=64CGxkVCN+tpcc5h0TLuNJ8a0+sAEqYpYu5ixxZ2mkg=;
        b=LPlrAqLP/r1SwN4Ni33l2KQkmUbmZQ5e2B8/T0hekORvqd7ZHsRdfVBuFJ+71qMGlI
         iNcSc7h4BDQPrR6lBAbeSfC2UjMpqitCX+rfJozQiFTo44sIVa9v3gYfOM6/hxSNwtAc
         SVRlyESM7ogE4R8gp9eKC7Bd4vn/+TDLdg1jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=64CGxkVCN+tpcc5h0TLuNJ8a0+sAEqYpYu5ixxZ2mkg=;
        b=SrQ9kHbmZzuJ0ONxGzltIoi9acypYYuW1Hu0+TU48cUyHgOiiSbDb+oM/pr3J3Xuti
         QwRgJtTkK41I7s9IAl/1qDpAo5viJoo1DS9FB8FjClPPz78osH287s/ZATdRykZJz8QG
         e+F375uqjWG/JOPqbEuyCTa1XQmyK9C3RJn+HdQt9/cJk07yIjEBh6VTDlc7xxHWN3R0
         Xq8z/1JV+UI4Vpo03o2kTV9vvLfz9GaB/qzdWCol+SeSFqhNyUCW3m/O6MxJs88o17ml
         pAIzFkuDBopcuVnBw5mJUnodR1GwCXGZD9MNFCWNElJBWWpG8kTgvSU7UV2bGnxMIs+j
         Gb3g==
X-Gm-Message-State: AGi0PuYSloBk+WqL8ImUNs51v6E4RHPh6SDU3W4BJ/P4sX7446gZDMx2
        /4EgksD8YuM6fOllpyZKCj48Gw==
X-Google-Smtp-Source: APiQypKI94JfKPIkpz/wT7WensQDX/0VxvYe7qtJDDSNIyHzhN59+sKmEZbVAOJ/tlrINrMpXAwDwA==
X-Received: by 2002:a17:90a:3606:: with SMTP id s6mr172866pjb.195.1585679213559;
        Tue, 31 Mar 2020 11:26:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r9sm8228895pfg.2.2020.03.31.11.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 11:26:52 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:26:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <202003311125.939F851A6@keescook>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
 <20200330224422.GX11244@42.do-not-panic.com>
 <8146e3d0-89c3-7f79-f786-084c58282c85@suse.cz>
 <20200331074836.GB30449@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331074836.GB30449@dhcp22.suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 31, 2020 at 09:48:36AM +0200, Michal Hocko wrote:
> On Tue 31-03-20 09:42:46, Vlastimil Babka wrote:
> [...]
> > > Should we not do this, we'll have to live with the consequences of
> > > supporting the full swoop of sysctls are boot params, whatever
> > > consequences those may be.
> > 
> > Of course when the first user tries to set some particular sysctl as boot param
> > and finds and reports it doesn't work as intended, then it can be fixed or
> > blacklisted and it can't break anyone else?
> 
> Absolutely agreed. I would be really careful to not overengineer this
> whole thing.

Right -- this is supposed to be _simple_, and I think that's the primary
benefit here. If we encounter problems we can fix those cases. The
careful place, I think, needs to be with converting existing boot params
to be aliases. That's when timing considerations need to be taken into
account carefully.

-- 
Kees Cook
