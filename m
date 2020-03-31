Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F45919A251
	for <lists+linux-api@lfdr.de>; Wed,  1 Apr 2020 01:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbgCaXO1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 31 Mar 2020 19:14:27 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55949 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731424AbgCaXO1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 31 Mar 2020 19:14:27 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02VNCsJL075329;
        Wed, 1 Apr 2020 08:12:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Wed, 01 Apr 2020 08:12:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02VNCsuC075325
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 1 Apr 2020 08:12:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH 3/3] kernel/hung_task convert hung_task_panic boot
 parameter to sysctl
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
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-4-vbabka@suse.cz>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <2ee52caa-0257-19bd-28ef-60a2b4041a8d@I-love.SAKURA.ne.jp>
Date:   Wed, 1 Apr 2020 08:12:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330115535.3215-4-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2020/03/30 20:55, Vlastimil Babka wrote:
> @@ -63,16 +63,6 @@ static struct task_struct *watchdog_task;
>  unsigned int __read_mostly sysctl_hung_task_panic =
>  				CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE;
>  
> -static int __init hung_task_panic_setup(char *str)
> -{
> -	int rc = kstrtouint(str, 0, &sysctl_hung_task_panic);
> -
> -	if (rc)
> -		return rc;
> -	return 1;
> -}
> -__setup("hung_task_panic=", hung_task_panic_setup);

Can we defer removal of this handler for "one release cycle" (and instead emit a line
saying that "this parameter will be replaced by ..." during that cycle) ? I welcome
PATCH 1/3, but kernel testing projects (e.g. syzbot) needs to update their settings
between PATCH 1/3 was merged into linux.git and PATCH 3/3 is merged into linux.git .

https://lkml.kernel.org/r/CACT4Y+YE-j5ncjTGN6UhngfCNRgVo-QDZ3VCBGACdbs9-v+axQ@mail.gmail.com says
"Announcing unmerged changes is too early (as this patch showed). And once it's in linux-next it's already too late.."

> -
>  static int
>  hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
>  {
> 
