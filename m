Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD38B1DEE3E
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2020 19:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbgEVR3z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 May 2020 13:29:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34030 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730554AbgEVR3z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 22 May 2020 13:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590168593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=15giI7Twfyx23sQ419l43txLDRcgrhknS5eEDxlCs+4=;
        b=UAuT8Yn0UoomkErKG4p+0Hhu6F7F3Hx9RUc6+EhrOB6k1c+R6G/iu1TOXaDBP39rikh4g1
        gL/9TYz/yU15PEWZVbg//INvZ/nWqiQdhZtYi+lAB+6bGZ+K74vIJLvaMgNpOEc9nrdgB9
        5j2EwBPweCi7+A8pzx51boxSqD5eP5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-6A89GSQQPGGX5UbHzh4Dqg-1; Fri, 22 May 2020 13:29:51 -0400
X-MC-Unique: 6A89GSQQPGGX5UbHzh4Dqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D890460;
        Fri, 22 May 2020 17:29:47 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7219E75262;
        Fri, 22 May 2020 17:29:36 +0000 (UTC)
Date:   Fri, 22 May 2020 19:29:34 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>, mtk.manpages@gmail.com
Subject: Re: [PATCH v10 26/26] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
Message-ID: <20200522172934.GI12341@asgard.redhat.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200429220732.31602-27-yu-cheng.yu@intel.com>
 <202005211528.A12B4AD@keescook>
 <c9c9314374c7db0bf9b6e39670855afe5b0d4014.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c9314374c7db0bf9b6e39670855afe5b0d4014.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 22, 2020 at 10:17:43AM -0700, Yu-cheng Yu wrote:
> On Thu, 2020-05-21 at 15:42 -0700, Kees Cook wrote:
> > On Wed, Apr 29, 2020 at 03:07:32PM -0700, Yu-cheng Yu wrote:
> [...]
> > > +
> > > +int prctl_cet(int option, u64 arg2)
> > > +{
> > > +	struct cet_status *cet;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_X86_INTEL_CET))
> > > +		return -EINVAL;
> > 
> > Using -EINVAL here means userspace can't tell the difference between an
> > old kernel and a kernel not built with CONFIG_X86_INTEL_CET. Perhaps
> > -ENOTSUPP?
> 
> Looked into this.  The kernel and GLIBC are not in sync.  So maybe we still use
> EINVAL here?
> 
> Yu-cheng
> 
> 
> 
> In kernel:
> ----------
> 
> #define EOPNOTSUPP	95
> #define ENOTSUPP 	524
> 
> In GLIBC:
> ---------
> 
> printf("ENOTSUP=%d\n", ENOTSUP);
> printf("EOPNOTSUPP=%d\n", EOPNOTSUPP);
> printf("%s=524\n", strerror(524));
>  
> ENOTSUP=95
> EOPNOTSUPP=95
> Unknown error 524=524

EOPNOTSUPP/ENOTSUP/ENOTSUPP is actually a mess, it's summarized recently
by Michael Kerrisk[1].  From the kernel's point of view, I think it
would be reasonable to return EOPNOTSUPP, and expect that the userspace
would use ENOTSUP to match against it.

[1] https://lore.kernel.org/linux-man/cb4c685b-6c5d-9c16-aade-0c95e57de4b9@gmail.com/

