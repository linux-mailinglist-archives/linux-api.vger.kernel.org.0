Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3991A917E
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2020 05:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgDODX2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Apr 2020 23:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgDODX2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 14 Apr 2020 23:23:28 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E902076C;
        Wed, 15 Apr 2020 03:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586921007;
        bh=E+A8GbmRdkiChcOTscbAJQjnd5pGOJMNuDZNPxk7gQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0K6+eu09mA4b4Wx8yvMa9i30yk8a4a1FWzBnikHTYAuTjvN9GNyB+1uNW4FFziyrc
         Jw7OYfxnTK0ZEPbPSRcTyCp2gZkbQVh46FTxNtmcoQbnaNGpHzZHmU60FBJv4TSaYf
         lANGZhUhbaY2ogdN5qlLEFGKQ/OTJZvBk1gNx8P8=
Date:   Wed, 15 Apr 2020 12:23:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
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
Subject: Re: [PATCH 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-Id: <20200415122320.70668776379706323bbc752e@kernel.org>
In-Reply-To: <7585f0b0-c5d2-b527-aac7-eeafdd15ffad@suse.cz>
References: <20200330115535.3215-1-vbabka@suse.cz>
        <20200330115535.3215-2-vbabka@suse.cz>
        <20200330224422.GX11244@42.do-not-panic.com>
        <287ac6ae-a898-3e68-c7d8-4c1d17a40db9@suse.cz>
        <20200402160442.GA11244@42.do-not-panic.com>
        <202004021017.3A23B759@keescook>
        <20200402205932.GM11244@42.do-not-panic.com>
        <202004031654.C4389A04EF@keescook>
        <20200406140836.GA11244@42.do-not-panic.com>
        <202004060856.6BC17C5C99@keescook>
        <20200406170822.GE11244@42.do-not-panic.com>
        <7585f0b0-c5d2-b527-aac7-eeafdd15ffad@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 14 Apr 2020 13:25:07 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 4/6/20 7:08 PM, Luis Chamberlain wrote:
> > On Mon, Apr 06, 2020 at 08:58:50AM -0700, Kees Cook wrote:
> >> On Mon, Apr 06, 2020 at 02:08:36PM +0000, Luis Chamberlain wrote:
> >> > > Yes. Doing an internal extension isn't testing the actual code.
> >> > 
> >> > But it would.
> >> > 
> >> > [...]
> >> > > I don't think anything is needed for this series. It can be boot tested
> >> > > manually.
> >> > 
> >> > Why test it manually when it could be tested automatically with a new kconfig?
> >> 
> >> So, my impression is that adding code to the internals to test the
> >> internals isn't a valid test (or at least makes it fragile) because the
> >> test would depend on the changes to the internals (or at least depend on
> >> non-default non-production CONFIGs).
> > 
> > The *internal* aspect here is an extension to boot params under a
> > kconfig which would simply append to it, as if the user would have
> 
> So there's no such kconfig yet to apply boot parameters specified by configure,
> right? That would itself be a new feature. Or could we use bootconfig? (CC Masami)

Yes, I think you can use bootconfig to add this feature more flexibly.
I think your patch is easily modified to use bootconfig. :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
