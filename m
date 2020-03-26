Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529DF193909
	for <lists+linux-api@lfdr.de>; Thu, 26 Mar 2020 07:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgCZG6d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Mar 2020 02:58:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38673 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCZG6d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Mar 2020 02:58:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id l20so5736698wmi.3;
        Wed, 25 Mar 2020 23:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WNr+H+i2h9AKUcba1Al2JvL3xo1ZLSPUjZ6Kc7JA57I=;
        b=mcTEka9QZb3w7GpSOEdHosHRbAQrkNe7V9Eqx4ZdXFYyU4JV1ABrewrMYDQbnlGXso
         V+BNGJg9avKZz+3HuqS1U3SJEKg2AbK53JU4xzY0sNbJn+Fsg3mpjFqqQw5IMYkCGYFH
         0ABTVZEQCN2uCsxc/JVj+ZyS8LYSyG9Hx5T9tEoHhKhS1ujytgkhkxy+Pdmlur7auW/p
         uGQpIcwoI44+IWax6W6B2MsdcWwF5sFkEx/6IT9lnoWKbWWLossWYjNzSm4fblo4ZnA4
         d4S4t8APyYxg0jlptcNq2xyArryLcK7Ul61pBxJS4kmSCGN/q+xrqUt5QhOMcb/6bB56
         8U4A==
X-Gm-Message-State: ANhLgQ2Ldutvin8sOVdl0nO6s+BiWFjB45CmDhIIVQf2+tKDeGTwR8Af
        an5TpotypDvH/iylAyz6eus=
X-Google-Smtp-Source: ADFU+vscvykjE0LsujRNMqBRjiwR5Fy2NQHMrSKyT3k1ZjEPNd/kX6YIOUXuoXPIPKLQTlTuYWhhxg==
X-Received: by 2002:a1c:b7c2:: with SMTP id h185mr1554055wmf.67.1585205911614;
        Wed, 25 Mar 2020 23:58:31 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id a192sm2287562wme.5.2020.03.25.23.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 23:58:30 -0700 (PDT)
Date:   Thu, 26 Mar 2020 07:58:29 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v2 1/2] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <20200326065829.GC27965@dhcp22.suse.cz>
References: <20200325120345.12946-1-vbabka@suse.cz>
 <874kuc5b5z.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kuc5b5z.fsf@x220.int.ebiederm.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 25-03-20 17:20:40, Eric W. Biederman wrote:
> Vlastimil Babka <vbabka@suse.cz> writes:
[...]
> > +	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1))
> > +		return 0;
> 
> Is there any way we can use a slash separated path.  I know
> in practice there are not any sysctl names that don't have
> a '.' in them but why should we artifically limit ourselves?

Because this is the normal userspace interface? Why should it be any
different from calling sysctl?
[...]

> Further it will be faster to lookup the sysctls using the code from
> proc_sysctl.c as it constructs an rbtree of all of the entries in
> a directory.  The code might as well take advantage of that for large
> directories.

Sounds like a good fit for a follow up patch to me. Let's make this
as simple as possible for the initial version. But up to Vlastimil of
course.

[...]

> Hmm.  There is a big gotcha in here and I think it should be mentioned.
> This code only works because no one has done set_fs(KERNEL_DS).  Which
> means this only works with strings that are kernel addresses essentially
> by mistake.  A big fat comment documenting why it is safe to pass in
> kernel addresses to a function that takes a "char __user*" pointer
> would be very good.

Agreed

-- 
Michal Hocko
SUSE Labs
