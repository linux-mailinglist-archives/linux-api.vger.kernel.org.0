Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD81A9180
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2020 05:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgDODYJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Apr 2020 23:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgDODYG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 14 Apr 2020 23:24:06 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6FA72076C;
        Wed, 15 Apr 2020 03:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586921046;
        bh=wTVTBdIHEqCex23yW6xwI9OoQMcfzXT4+ioyVchFUpQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SfgtJRTcjPqkS72/m2sKOzvm1oR0MQnLje3I7RBxdagvdugW7f21nTRsWItsS62Om
         4ua6aAcdc1lphqCNXdIWozTCflGDucinEtWwGZ75IfujdrkhsLsMIVb4xDpJfWp3dM
         eTGgBBUrs5bYS3IBK1IWiTLhp6ohQbxOCpdf5iG8=
Date:   Wed, 15 Apr 2020 12:23:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
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
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 0/3] support setting sysctl parameters from kernel
 command line
Message-Id: <20200415122359.939364e2c54c389c6b3f6457@kernel.org>
In-Reply-To: <20200414113222.16959-1-vbabka@suse.cz>
References: <20200414113222.16959-1-vbabka@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Vlastimil,

On Tue, 14 Apr 2020 13:32:19 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> This series adds support for something that seems like many people always
> wanted but nobody added it yet, so here's the ability to set sysctl parameters
> via kernel command line options in the form of sysctl.vm.something=1

Sounds good. And would you consider to use the bootconfig instead of (or
in addition to) the kernel command line, because it is too short to describe
the sysctl options?

With the bootconfig, you can describe the sysctl parameters in an
independent file as same as /etc/sysctl.conf. It is easy to convert
form sysctl.conf to bootconfig because bootconfig format is simply
enhanced structured sysctl.conf :). What we just need is;

(echo "sysctl {"; cat "/etc/sysctl.conf"; echo "}") >> sysctl.bconf
bootconfig -a sysctl.bconf /boot/initrd.img

Even with only your patch, since bootconfig can pass the options which
start with "kernel." prefix to kernel command line, so;

(echo "kernel.sysctl {"; cat "/etc/sysctl.conf"; echo "}") >> sysctl.bconf
bootconfig -a sysctl.bconf /boot/initrd.img

should work. 

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
