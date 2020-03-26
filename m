Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 044A1194A92
	for <lists+linux-api@lfdr.de>; Thu, 26 Mar 2020 22:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCZV3O (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Mar 2020 17:29:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57001 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZV3O (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Mar 2020 17:29:14 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jHa3m-0005bi-TH; Thu, 26 Mar 2020 21:29:07 +0000
Date:   Thu, 26 Mar 2020 22:29:06 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v3 2/2] kernel/sysctl: support handling command line aliases
Message-ID: <20200326212906.muutd636zfoytcgh@wittgenstein>
References: <20200326181606.7027-1-vbabka@suse.cz>
 <20200326181606.7027-2-vbabka@suse.cz>
 <202003261329.AAFEE9C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202003261329.AAFEE9C@keescook>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 26, 2020 at 01:34:08PM -0700, Kees Cook wrote:
> On Thu, Mar 26, 2020 at 07:16:06PM +0100, Vlastimil Babka wrote:
> > We can now handle sysctl parameters on kernel command line, but historically
> > some parameters introduced their own command line equivalent, which we don't
> > want to remove for compatibility reasons. We can however convert them to the
> > generic infrastructure with a table translating the legacy command line
> > parameters to their sysctl names, and removing the one-off param handlers.
> > 
> > This patch adds the support and makes the first conversion to demonstrate it,
> > on the (deprecated) numa_zonelist_order parameter.
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> > Changes in v3:
> > - constify some things according to Kees
> > - expand the comment of sysctl_aliases to note on different timings
> > 
> >  fs/proc/proc_sysctl.c | 48 ++++++++++++++++++++++++++++++++++++-------
> >  mm/page_alloc.c       |  9 --------
> >  2 files changed, 41 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > index 8ee3273e4540..3a861e0a7c7e 100644
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -1729,6 +1729,37 @@ int __init proc_sys_init(void)
> >  
> >  struct vfsmount *proc_mnt = NULL;
> >  
> > +struct sysctl_alias {
> > +	const char *kernel_param;
> > +	const char *sysctl_param;
> > +};
> > +
> > +/*
> > + * Historically some settings had both sysctl and a command line parameter.
> > + * With the generic sysctl. parameter support, we can handle them at a single
> > + * place and only keep the historical name for compatibility. This is not meant
> > + * to add brand new aliases. When adding existing aliases, consider whether
> > + * the possibly different moment of changing the value (e.g. from early_param
> > + * to the moment do_sysctl_args() is called) is an issue for the specific
> > + * parameter.
> > + */
> > +static const struct sysctl_alias sysctl_aliases[] = {
> > +	{"numa_zonelist_order",		"vm.numa_zonelist_order" },
> > +	{ }
> > +};
> > +
> > +const char *sysctl_find_alias(char *param)
> 
> This should be "static" too.
> 
> > +{
> > +	const struct sysctl_alias *alias;
> > +
> > +	for (alias = &sysctl_aliases[0]; alias->kernel_param != NULL; alias++) {
> > +		if (strcmp(alias->kernel_param, param) == 0)
> > +			return alias->sysctl_param;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> >  /* Set sysctl value passed on kernel command line. */
> >  static int process_sysctl_arg(char *param, char *val,
> >  			       const char *unused, void *arg)
> > @@ -1741,15 +1772,18 @@ static int process_sysctl_arg(char *param, char *val,
> >  	loff_t pos = 0;
> >  	ssize_t wret;
> >  
> > -	if (strncmp(param, "sysctl", sizeof("sysctl") - 1))

Somewhat off-topic but in some projects I use macro-helpers to make that
more transparent. So this would become a constant expression:

#define STRLITERALLEN(x) (sizeof(""x"") - 1)
or
#define STRLEN(x) (sizeof(""x"") - 1)

But I guess that's a matter of style/taste.

Christian
