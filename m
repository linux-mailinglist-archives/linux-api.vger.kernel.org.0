Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106251AB7A1
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2020 08:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407167AbgDPGCT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Apr 2020 02:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407165AbgDPGCN (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 16 Apr 2020 02:02:13 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94EEA2076A;
        Thu, 16 Apr 2020 06:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587016932;
        bh=H95Q/syDnIOT80mK9pLWTpk+EblpARC2OaGNoxyxAiw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oAet7vuPUBRUElKdTjJcmSJ6ELXSNTpWsbnm60yn9+4UnifDG+l8n2NPbSf5FPtZ9
         1U6C6/MVqik5+/djGWSe2Gf8hwEr3OSdXNxzP4vdiAMdlgq8bCnXuMOQOsVn9YKbXY
         JgtPw4hu85/iVYpCPrhhtkGX5tA//9IcGEWs4BTw=
Date:   Thu, 16 Apr 2020 15:02:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-Id: <20200416150206.d3e103a1a5497b3518d4359c@kernel.org>
In-Reply-To: <20200415063041.GT11244@42.do-not-panic.com>
References: <20200414113222.16959-1-vbabka@suse.cz>
        <20200415122359.939364e2c54c389c6b3f6457@kernel.org>
        <20200415063041.GT11244@42.do-not-panic.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Luis,

On Wed, 15 Apr 2020 06:30:41 +0000
Luis Chamberlain <mcgrof@kernel.org> wrote:
> Currently the maximum config size size is 32KB and the total key-words
> (not     key-value entries) must be under 1024 nodes.  Note: this is not
> the number of entries but nodes, an entry must consume more than 2 nodes
> (a key-word and a value). So theoretically, it will be up to 512
> key-value pairs. If keys contains 3 words in average, it can contain 256
> key-value pairs. In most cases, the number of config items will be under
> 100 entries and smaller than 8KB, so it would be enough.  If the node
> number exceeds 1024, parser returns an error even if the file       size
> is smaller than 32KB.  Anyway, since bootconfig command verifies it when
> appending a boot config       to initrd image, user can notice it before
> boot.  
> ```
> *recommending* bootconfig due to the limitation of cmdline seems
> sensible, however if we advise that.. wouldn't the space for 512
> theoretical entries full up rather fast?

Yeah, I think it is easier to hit the node number limitation rather
than fill up the space. However, since the bootconfig supports comments,
if user writes enough readable config file, I think it's probably the
right balance :)
If you think the 512 entries is too small, it is easy to expand it
upto 32K (64K nodes). But it may consume 512KB memory only for the
node (meta) data. Current 1024 nodes consumes 8KB (8bytes/node), so
compared with the max data size (32KB), I think it is a better balance.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
