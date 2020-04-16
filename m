Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA301AB586
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2020 03:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbgDPB3w (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Apr 2020 21:29:52 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35645 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732857AbgDPB3e (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Apr 2020 21:29:34 -0400
Received: by mail-pj1-f65.google.com with SMTP id mn19so664130pjb.0;
        Wed, 15 Apr 2020 18:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PnF7XX+HBiChqiEIw8vxgcw83sjsqf5rskmR8bV1uhE=;
        b=tWAj7qQd3oeZN5sWwnVVRe4xAV12h+mS3jvZkW2q26cKjI0ws0MZpgxSjdBp2X89TL
         nEr6pbrnz4QMcRGbj+VEEHfYvDcPi3DtUxJaBGjxfcWRwvJQTAKyuCZjq/3dZVUWkUfu
         ks4VkAXmBo/NTNisgYSILUWRc2+TEdsmwUEyn6OWfUaNM+l0916CPzDf8/n1GvpBVwnF
         jw8sUPvl6SwzlaF/YZmjm0MasLdblBEtB35XxHMhhsoz4oSe6byloOeFJJQmq1NeD2mB
         C1y0pWjLixQn/Ez1QOOSnylxRL4vDt0EO054231cc2HPY4y2CYCZpPZ/1iZ3LTZuqDWA
         9wGg==
X-Gm-Message-State: AGi0PuZLOkNixjirGeobqh2HSgjhxEppQk0FIJREQoU0yz7mZ43nKIF4
        DlKmrMVQ5uoh2PcUuyVjSug=
X-Google-Smtp-Source: APiQypL1Zry+M+f03DM3k+FuGlRfqeq4ZVim5hUX+tX4P9pE4l69kAMRnRCmwP6mQT5TXwK/Pbzv0g==
X-Received: by 2002:a17:902:441:: with SMTP id 59mr7374218ple.339.1587000574181;
        Wed, 15 Apr 2020 18:29:34 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a136sm12241605pfa.99.2020.04.15.18.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 18:29:32 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C0B9240277; Thu, 16 Apr 2020 01:29:31 +0000 (UTC)
Date:   Thu, 16 Apr 2020 01:29:31 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <20200416012931.GE11244@42.do-not-panic.com>
References: <20200414113222.16959-1-vbabka@suse.cz>
 <20200414113222.16959-2-vbabka@suse.cz>
 <20200415180355.00bc828ea726c421638db871@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415180355.00bc828ea726c421638db871@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Apr 15, 2020 at 06:03:55PM +0900, Masami Hiramatsu wrote:
> On Tue, 14 Apr 2020 13:32:20 +0200
> Vlastimil Babka <vbabka@suse.cz> wrote:
> > diff --git a/init/main.c b/init/main.c
> > index a48617f2e5e5..7b43118215d6 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1372,6 +1372,8 @@ static int __ref kernel_init(void *unused)
> >  
> >  	rcu_end_inkernel_boot();
> >  
> > +	do_sysctl_args();
> > +
> 
> Ah, I see. Since the sysctl is designed to be called after all __init calls were
> done, it shouldn't use bootconfig directly because bootconfig is full of __init
> call.

The idea is bootconfig would be useful in the sense of a library set of
helpers which could be modified to remove __init, and then used to
instrument the cmdline depending on certain debugging kconfig entries.

We currently have no way to purposely extend / break the cmdline for
debugging purposes, so, bootconfig's parsers, since it already has a
way to extend the cmdlineline, might make it much easier to do this
later.

Without bootconfig, if we wanted to add new kconfig to, for example,
add new funny cmdline arguments to test they worked or not, we'd have
to devise our own set of helpers now. ie, new functionality. bootconfig
however already has existing functionality to tweak the cmdline, and so
some code could be leveraged there for this purpose.

  Luis
