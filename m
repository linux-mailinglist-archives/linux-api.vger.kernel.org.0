Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9741A99CF
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2020 12:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896092AbgDOKBy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Apr 2020 06:01:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55613 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895955AbgDOKBu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Apr 2020 06:01:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id e26so16700737wmk.5;
        Wed, 15 Apr 2020 03:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ik9SzoJG23HyWV3EJZBDw9KnoLZv3eWb0eYaCp2cs4I=;
        b=YGaPNOVt6IA3KnoXCM3zXS55D4HzzWJBbGHn9eorupAT6wY0Z0lpwUNM/e2N1lGGrm
         D1nwmd2a2tMgDrHQg9QFdJy3KZ4HoABciG3wtw16qnLBHKuW4VoRUMZJ/ok9+BFd6LFY
         QTtHs76ObpZxxSMcHu8CMbOtAPngw8DUsj1gCM+Nya2uGQWUNmb3HcZ4UepBnsVJIh41
         ov2AYhOK2jVQQAF8PuoW4aXnUhi6Akqbyuc2nkDCAZ4P8vxZ+0DfrFwpQDIk4vyyxGV1
         XoUfyc4XJ3PcjesRpLi3NZBWmOT0S9nAE/8Mk6a8tJD7Zn/hcNLp9SH7hcN4i0oTHOAM
         gQ7A==
X-Gm-Message-State: AGi0PuaWciEnYj21oRvokxyY43G66LLAn5bOIWuKdxjY8k2B88iBNO1Y
        iyeIJw/Vq+7w7yLD9yv6nKI=
X-Google-Smtp-Source: APiQypKJVaGGm0WlX/P9D+5uZGAAwOwvoL0TgNtVED/ZyGRV1UePRP4N+INs4Ka7TCh9PUHB/SON9w==
X-Received: by 2002:a1c:3d83:: with SMTP id k125mr4767806wma.177.1586944909281;
        Wed, 15 Apr 2020 03:01:49 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id 1sm21770489wmi.0.2020.04.15.03.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 03:01:48 -0700 (PDT)
Date:   Wed, 15 Apr 2020 12:01:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH v2 0/3] support setting sysctl parameters from kernel
 command line
Message-ID: <20200415100146.GC4629@dhcp22.suse.cz>
References: <20200414113222.16959-1-vbabka@suse.cz>
 <20200415122359.939364e2c54c389c6b3f6457@kernel.org>
 <3fc1303a-cb57-b96e-ce77-7ff6407ab538@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fc1303a-cb57-b96e-ce77-7ff6407ab538@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 15-04-20 10:56:35, Vlastimil Babka wrote:
> On 4/15/20 5:23 AM, Masami Hiramatsu wrote:
> > Hi Vlastimil,
> > 
> > On Tue, 14 Apr 2020 13:32:19 +0200
> > Vlastimil Babka <vbabka@suse.cz> wrote:
> > 
> >> This series adds support for something that seems like many people always
> >> wanted but nobody added it yet, so here's the ability to set sysctl parameters
> >> via kernel command line options in the form of sysctl.vm.something=1
> > 
> > Sounds good. And would you consider to use the bootconfig instead of (or
> > in addition to) the kernel command line, because it is too short to describe
> > the sysctl options?
> 
> "Instead of" - no, as that would defeat the scenario of "I just want to set this
> one sysctl in grub  (possibly interactively) and not update initrd for that". If
> constructing bootconfig is of similar effort of loading sysctl.conf from initrd,
> then I see little benefit?
> 
> "in addition to" - sure! but I hoped that's what already happens as it seemed to
> me that options from bootconfig are appended to the command line that's then
> parsed by everyone else, no? But I'll try it to be sure.

Completely agreed!

Btw. patches look sensible to me so feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs
