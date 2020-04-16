Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEF21AB833
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2020 08:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408370AbgDPGio (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Apr 2020 02:38:44 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52478 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408187AbgDPGii (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Apr 2020 02:38:38 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so942500pjb.2;
        Wed, 15 Apr 2020 23:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JhqXMpaDtR4QdQFxjiccypTqasAwt8uY42ZQFRo6zec=;
        b=H6AK+DKim638KwerflDntjT2jf1x14TBm9C6zOsdPFoqEih3990vcisd6/TnAhakUJ
         0LWzjKOb6WAqJKMOWcIOOxfwicAsecwKJNrYvxA9zkz/YMHEUiCa4O9ygR0EeUwJLccW
         jG0uvsTTDe3PWtCLgf/DV4yrAO2Y+5+VG4a0AV84q8G3ioM1kA8TB66xzLkSLgZ/cird
         n59XRfLQaO3g07iZksPZ4LZQm8jztm45emIccOp5OZmdKVLYnh1+LZikQNVuf3nGMOLB
         zQ6xW1Fb0ibItMvgwWD0eyW4FUOqmSvYEqLKzNB4z//cpsuWFRR9eH++Uo+X/Khx6O/b
         7Dgw==
X-Gm-Message-State: AGi0PuYhJUWV+f05SICbS6ZbnU+WyaB5hs615tngb0z/aHFvdOp2vxil
        m8huFyhRph8LtrJU6yoRw+mbMse/uhE=
X-Google-Smtp-Source: APiQypLiX3EEejSxMY4gob9qPf7SrIgOr5sEycuMHTgXEAp2MDuLtUM6+B/3dTfOGpjnAYR05+tkBA==
X-Received: by 2002:a17:902:107:: with SMTP id 7mr8248874plb.302.1587019116498;
        Wed, 15 Apr 2020 23:38:36 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p8sm1549014pjd.10.2020.04.15.23.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 23:38:35 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7570B40277; Thu, 16 Apr 2020 06:38:34 +0000 (UTC)
Date:   Thu, 16 Apr 2020 06:38:34 +0000
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
Subject: Re: [PATCH v2 0/3] support setting sysctl parameters from kernel
 command line
Message-ID: <20200416063834.GO11244@42.do-not-panic.com>
References: <20200414113222.16959-1-vbabka@suse.cz>
 <20200415122359.939364e2c54c389c6b3f6457@kernel.org>
 <20200415063041.GT11244@42.do-not-panic.com>
 <20200416150206.d3e103a1a5497b3518d4359c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416150206.d3e103a1a5497b3518d4359c@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 16, 2020 at 03:02:06PM +0900, Masami Hiramatsu wrote:
> Hi Luis,
> 
> On Wed, 15 Apr 2020 06:30:41 +0000
> Luis Chamberlain <mcgrof@kernel.org> wrote:
> > Currently the maximum config size size is 32KB and the total key-words
> > (not     key-value entries) must be under 1024 nodes.  Note: this is not
> > the number of entries but nodes, an entry must consume more than 2 nodes
> > (a key-word and a value). So theoretically, it will be up to 512
> > key-value pairs. If keys contains 3 words in average, it can contain 256
> > key-value pairs. In most cases, the number of config items will be under
> > 100 entries and smaller than 8KB, so it would be enough.  If the node
> > number exceeds 1024, parser returns an error even if the file       size
> > is smaller than 32KB.  Anyway, since bootconfig command verifies it when
> > appending a boot config       to initrd image, user can notice it before
> > boot.  
> > ```
> > *recommending* bootconfig due to the limitation of cmdline seems
> > sensible, however if we advise that.. wouldn't the space for 512
> > theoretical entries full up rather fast?
> 
> Yeah, I think it is easier to hit the node number limitation rather
> than fill up the space. However, since the bootconfig supports comments,
> if user writes enough readable config file, I think it's probably the
> right balance :)
> If you think the 512 entries is too small, it is easy to expand it
> upto 32K (64K nodes). But it may consume 512KB memory only for the
> node (meta) data. Current 1024 nodes consumes 8KB (8bytes/node), so
> compared with the max data size (32KB), I think it is a better balance.

Yeah, and well at least x86 / x86_64 sets COMMAND_LINE_SIZE to 2048
right now (2 KB), that'd hit the limit of abuse of cmdline pretty fast
too. I see no way to scale this reasonably if people abuse syctls on
the command line but to use bootconfig and bite the bullet on size,
to keep sanity.

  Luis
