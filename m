Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E69BD1986FF
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2020 00:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgC3WJo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Mar 2020 18:09:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40945 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgC3WJn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Mar 2020 18:09:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id t24so9342617pgj.7;
        Mon, 30 Mar 2020 15:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j7FmspK21WqfyDNNhuaL3ZlTlaa7O+RnMjIkIEqFuiw=;
        b=su818cT3WfQlUr0ieQYTl5TpuDrJ7aGCv8uzHlTBm5DZjQy/laMDyPgqzuKvEpMBz8
         +ZsQdxJpoCIabRbCtmxtoilJ9VJ0sqHWoQXsLzlV34eSMZaOkGUtMt3as4L+eIUME5up
         mNBgl4UaB7v0pyVBN8Qxii7+AaVwlFNt0+BHjM8H4txepliJxi7X0Dxrx95zjVDRxYSc
         aMfo43HCQ6tdMKsi+lChfsXfwqKxicPe/2K4tYaNmyTTpLdrhSy+x7oBnVkIBxWTxGmA
         QejmHSWUpsH0FSjXxpaZblB/20fIpLqHpXz/4JnxGAtwZXLv0VYz7B/1TxpaSO5UfMrb
         XeEg==
X-Gm-Message-State: ANhLgQ0fdMgRtzQ1Fc2qcoDjKN01AJA8EUncnaHZpnt4Rj5lud2b8Key
        UA1U5lxEyRn3DQLTunCua8c=
X-Google-Smtp-Source: ADFU+vvPzerl8j1+L7xAnyd4gLFIsKX6lP6TPO/c76Xt2g0Nx6dQq/wpEsf4qIQGjiT4CSIoeAaL8g==
X-Received: by 2002:a62:1745:: with SMTP id 66mr15223339pfx.291.1585606181235;
        Mon, 30 Mar 2020 15:09:41 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b133sm9608378pfb.180.2020.03.30.15.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:09:40 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 61A9F404B0; Mon, 30 Mar 2020 22:09:39 +0000 (UTC)
Date:   Mon, 30 Mar 2020 22:09:39 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v2 1/2] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <20200330220939.GW11244@42.do-not-panic.com>
References: <20200325120345.12946-1-vbabka@suse.cz>
 <874kuc5b5z.fsf@x220.int.ebiederm.org>
 <20200326065829.GC27965@dhcp22.suse.cz>
 <87bloj2skm.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bloj2skm.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 26, 2020 at 07:45:13AM -0500, Eric W. Biederman wrote:
> > On Wed 25-03-20 17:20:40, Eric W. Biederman wrote:
> plus I want to get very far away from the incorrect idea that you
> can have sysctls without compiling in proc support.  That is not how
> the code works, that is not how the code is tested.

Agreed.

> It is also worth pointing out that:
> 
> 	proc_mnt = kern_mount(proc_fs_type);
>         for_each_sysctl_cmdline() {
>         	...
> 		file = file_open_root(proc_mnt->mnt_root, proc_mnt, sysctl_path, O_WRONLY, 0);
> 		kernel_write(file, value, value_len);
>         }
>         kern_umount(proc_mnt);
> 
> Is not an unreasonable implementation.

This:

> There are problems with a persistent mount of proc in that it forces
> userspace not to use any proc mount options.  But a temporary mount of
> proc to deal with command line options is not at all unreasonable.
> Plus it looks like we can have kern_write do all of the kernel/user
> buffer silliness.

Is a bit of tribal knowledge worth documenting for the approach taken
forward. Vlastimil can you add a little comment mentioning some of this
logic?

  Luis
