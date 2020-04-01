Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716E519A7A6
	for <lists+linux-api@lfdr.de>; Wed,  1 Apr 2020 10:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgDAIrL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 1 Apr 2020 04:47:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:55962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgDAIrL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 1 Apr 2020 04:47:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D5201ACE8;
        Wed,  1 Apr 2020 08:47:08 +0000 (UTC)
Subject: Re: [PATCH 3/3] kernel/hung_task convert hung_task_panic boot
 parameter to sysctl
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
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
 <2ee52caa-0257-19bd-28ef-60a2b4041a8d@I-love.SAKURA.ne.jp>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9a11d5c9-b830-040e-219a-64cdb24a9236@suse.cz>
Date:   Wed, 1 Apr 2020 10:47:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2ee52caa-0257-19bd-28ef-60a2b4041a8d@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4/1/20 1:12 AM, Tetsuo Handa wrote:
> On 2020/03/30 20:55, Vlastimil Babka wrote:
>> @@ -63,16 +63,6 @@ static struct task_struct *watchdog_task;
>>  unsigned int __read_mostly sysctl_hung_task_panic =
>>  				CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE;
>>  
>> -static int __init hung_task_panic_setup(char *str)
>> -{
>> -	int rc = kstrtouint(str, 0, &sysctl_hung_task_panic);
>> -
>> -	if (rc)
>> -		return rc;
>> -	return 1;
>> -}
>> -__setup("hung_task_panic=", hung_task_panic_setup);
> 
> Can we defer removal of this handler for "one release cycle" (and instead emit a line
> saying that "this parameter will be replaced by ..." during that cycle) ? I welcome

The old parameter is not removed, it's just handled differently, see patch 2.
Both old name and new sysctl.name will work.

> PATCH 1/3, but kernel testing projects (e.g. syzbot) needs to update their settings
> between PATCH 1/3 was merged into linux.git and PATCH 3/3 is merged into linux.git .
> 
> https://lkml.kernel.org/r/CACT4Y+YE-j5ncjTGN6UhngfCNRgVo-QDZ3VCBGACdbs9-v+axQ@mail.gmail.com says
> "Announcing unmerged changes is too early (as this patch showed). And once it's in linux-next it's already too late.."
> 
>> -
>>  static int
>>  hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
>>  {
>> 
> 

