Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D899C1A97AD
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2020 10:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405108AbgDOI4o (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Apr 2020 04:56:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:50008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405268AbgDOI4j (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 Apr 2020 04:56:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DD294AF92;
        Wed, 15 Apr 2020 08:56:35 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] support setting sysctl parameters from kernel
 command line
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
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
References: <20200414113222.16959-1-vbabka@suse.cz>
 <20200415122359.939364e2c54c389c6b3f6457@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <3fc1303a-cb57-b96e-ce77-7ff6407ab538@suse.cz>
Date:   Wed, 15 Apr 2020 10:56:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415122359.939364e2c54c389c6b3f6457@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4/15/20 5:23 AM, Masami Hiramatsu wrote:
> Hi Vlastimil,
> 
> On Tue, 14 Apr 2020 13:32:19 +0200
> Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> This series adds support for something that seems like many people always
>> wanted but nobody added it yet, so here's the ability to set sysctl parameters
>> via kernel command line options in the form of sysctl.vm.something=1
> 
> Sounds good. And would you consider to use the bootconfig instead of (or
> in addition to) the kernel command line, because it is too short to describe
> the sysctl options?

"Instead of" - no, as that would defeat the scenario of "I just want to set this
one sysctl in grub  (possibly interactively) and not update initrd for that". If
constructing bootconfig is of similar effort of loading sysctl.conf from initrd,
then I see little benefit?

"in addition to" - sure! but I hoped that's what already happens as it seemed to
me that options from bootconfig are appended to the command line that's then
parsed by everyone else, no? But I'll try it to be sure.

> With the bootconfig, you can describe the sysctl parameters in an
> independent file as same as /etc/sysctl.conf. It is easy to convert
> form sysctl.conf to bootconfig because bootconfig format is simply
> enhanced structured sysctl.conf :). What we just need is;
> 
> (echo "sysctl {"; cat "/etc/sysctl.conf"; echo "}") >> sysctl.bconf
> bootconfig -a sysctl.bconf /boot/initrd.img
> 
> Even with only your patch, since bootconfig can pass the options which
> start with "kernel." prefix to kernel command line, so;
> 
> (echo "kernel.sysctl {"; cat "/etc/sysctl.conf"; echo "}") >> sysctl.bconf
> bootconfig -a sysctl.bconf /boot/initrd.img

Hmm I hope I figure out if the way virtme creates initrd on the fly supports
hooking a bootconfig addition :)

> should work. 
> 
> Thank you,
> 
> 

