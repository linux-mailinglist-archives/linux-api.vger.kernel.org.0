Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292171A9344
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2020 08:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634881AbgDOGar (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Apr 2020 02:30:47 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40025 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634860AbgDOGao (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Apr 2020 02:30:44 -0400
Received: by mail-pj1-f66.google.com with SMTP id a22so1897026pjk.5;
        Tue, 14 Apr 2020 23:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4LxcdXE4D1IxsThm3AhK7U6oJIApRsieXToTt1nK21A=;
        b=s4N0X4UW5dadmnNR0mWMOazvtZM0Dx1BKiO0E+IZShk++erPeNdVkqduzMQteG2vLf
         xm2jUfZS41xbG5g5Los2JHdGscep2QjyqWrZOlqWduhpGuuVK6WiK7Un1RjhfOt8msg+
         IFlFbNJQ4ltVVp5SpBXjgAQz+8QFHtD62uOeIvInZQVtHL9FXA9zUWpcW9+4SpJzNNkR
         BW/bL7e21cGcxizPlEzBC3344rO75d+Hv/EV4FUj1RXj2+1ZFBtd5MMcaVMCXSZBbPka
         efFhIudidFd8tEhl4YOhd9+84+RV6UDjfzEx46CizHS1aT8p7SCICieZFvmp5iVwWD0m
         R8PA==
X-Gm-Message-State: AGi0PuZAmulZ2b5W5IbCCcRQ4ukfYGxQ1p8FEBKNp0lgxIiEZRYMkD01
        PrcMU2WssoHF/bjCsW+Jhro=
X-Google-Smtp-Source: APiQypJFLgQFEvz8AfxQfJ1OPsrl6W7Iz6lebKgSICb68UwY5Tr8ekRd4l9VhDpF57YV7QrUZX+Vnw==
X-Received: by 2002:a17:90a:d101:: with SMTP id l1mr4382396pju.79.1586932243703;
        Tue, 14 Apr 2020 23:30:43 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d188sm12635163pfa.7.2020.04.14.23.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 23:30:42 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id CFE4340277; Wed, 15 Apr 2020 06:30:41 +0000 (UTC)
Date:   Wed, 15 Apr 2020 06:30:41 +0000
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
Message-ID: <20200415063041.GT11244@42.do-not-panic.com>
References: <20200414113222.16959-1-vbabka@suse.cz>
 <20200415122359.939364e2c54c389c6b3f6457@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415122359.939364e2c54c389c6b3f6457@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Apr 15, 2020 at 12:23:59PM +0900, Masami Hiramatsu wrote:
> Hi Vlastimil,
> 
> On Tue, 14 Apr 2020 13:32:19 +0200
> Vlastimil Babka <vbabka@suse.cz> wrote:
> 
> > This series adds support for something that seems like many people always
> > wanted but nobody added it yet, so here's the ability to set sysctl parameters
> > via kernel command line options in the form of sysctl.vm.something=1
> 
> Sounds good. And would you consider to use the bootconfig instead of (or
> in addition to) the kernel command line, because it is too short to describe
> the sysctl options?

FWIW for the lazy:

The cmdline limitation:

Documentation/admin-guide/kernel-parameters.rst

```
The number of kernel parameters is not limited, but the length of the           
complete command line (parameters including spaces etc.) is limited to          
a fixed number of characters. This limit depends on the architecture            
and is between 256 and 4096 characters. It is defined in the file               
./include/asm/setup.h as COMMAND_LINE_SIZE.
```

The bootconfig limitation:

Documentation/admin-guide/bootconfig.rst

```
Currently the maximum config size size is 32KB and the total key-words
(not     key-value entries) must be under 1024 nodes.  Note: this is not
the number of entries but nodes, an entry must consume more than 2 nodes
(a key-word and a value). So theoretically, it will be up to 512
key-value pairs. If keys contains 3 words in average, it can contain 256
key-value pairs. In most cases, the number of config items will be under
100 entries and smaller than 8KB, so it would be enough.  If the node
number exceeds 1024, parser returns an error even if the file       size
is smaller than 32KB.  Anyway, since bootconfig command verifies it when
appending a boot config       to initrd image, user can notice it before
boot.  
```
*recommending* bootconfig due to the limitation of cmdline seems
sensible, however if we advise that.. wouldn't the space for 512
theoretical entries full up rather fast?

  Luis
