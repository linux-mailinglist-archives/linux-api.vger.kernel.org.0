Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C5F19811D
	for <lists+linux-api@lfdr.de>; Mon, 30 Mar 2020 18:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgC3QYB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Mar 2020 12:24:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:56952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgC3QYB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 30 Mar 2020 12:24:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 46CBEAD63;
        Mon, 30 Mar 2020 16:23:59 +0000 (UTC)
Subject: Re: [PATCH 1/3] kernel/sysctl: support setting sysctl parameters from
 kernel command line
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
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
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c68b1ed4-51ef-ca65-7128-ff3c8b6b54ee@suse.cz>
Date:   Mon, 30 Mar 2020 18:23:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330115535.3215-2-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/30/20 1:55 PM, Vlastimil Babka wrote:
> A recently proposed patch to add vm_swappiness command line parameter in
> addition to existing sysctl [1] made me wonder why we don't have a general
> support for passing sysctl parameters via command line. Googling found only
> somebody else wondering the same [2], but I haven't found any prior discussion
> with reasons why not to do this.
> 
> Settings the vm_swappiness issue aside (the underlying issue might be solved in
> a different way), quick search of kernel-parameters.txt shows there are already
> some that exist as both sysctl and kernel parameter - hung_task_panic,
> nmi_watchdog, numa_zonelist_order, traceoff_on_warning. A general mechanism
> would remove the need to add more of those one-offs and might be handy in
> situations where configuration by e.g. /etc/sysctl.d/ is impractical.
> 
> Hence, this patch adds a new parse_args() pass that looks for parameters
> prefixed by 'sysctl.' and tries to interpret them as writes to the
> corresponding sys/ files using an temporary in-kernel procfs mount. This
> mechanism was suggested by Eric W. Biederman [3], as it handles all dynamically
> registered sysctl tables. Errors due to e.g. invalid parameter name or value
> are reported in the kernel log.
> 
> The processing is hooked right before the init process is loaded, as some
> handlers might be more complicated than simple setters and might need some
> subsystems to be initialized. At the moment the init process can be started and
> eventually execute a process writing to /proc/sys/ then it should be also fine
> to do that from the kernel.
> 
> Sysctls registered later on module load time are not set by this mechanism -
> it's expected that in such scenarios, setting sysctl values from userspace is
> practical enough.
> 
> [1] https://lore.kernel.org/r/BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com/
> [2] https://unix.stackexchange.com/questions/558802/how-to-set-sysctl-using-kernel-command-line-parameter
> [3] https://lore.kernel.org/r/87bloj2skm.fsf@x220.int.ebiederm.org/
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Boo, all the error prints should terminate with \n
Will wait for feedback before resend.
