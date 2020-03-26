Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 848B9193FC2
	for <lists+linux-api@lfdr.de>; Thu, 26 Mar 2020 14:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgCZNau (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Mar 2020 09:30:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39779 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgCZNau (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Mar 2020 09:30:50 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jHSao-0003tR-O0; Thu, 26 Mar 2020 13:30:42 +0000
Date:   Thu, 26 Mar 2020 14:30:41 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v2 1/2] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <20200326133041.a3zit3gzdqmphane@wittgenstein>
References: <20200325120345.12946-1-vbabka@suse.cz>
 <874kuc5b5z.fsf@x220.int.ebiederm.org>
 <20200326065829.GC27965@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326065829.GC27965@dhcp22.suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 26, 2020 at 07:58:29AM +0100, Michal Hocko wrote:
> On Wed 25-03-20 17:20:40, Eric W. Biederman wrote:
> > Vlastimil Babka <vbabka@suse.cz> writes:
> [...]
> > > +	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1))
> > > +		return 0;
> > 
> > Is there any way we can use a slash separated path.  I know
> > in practice there are not any sysctl names that don't have
> > a '.' in them but why should we artifically limit ourselves?
> 
> Because this is the normal userspace interface? Why should it be any
> different from calling sysctl?
> [...]

Imho, we should use ".". Kernel developers aren't the ones setting
these options, admins are and if I think back to the times doing that as
a job at uni I'd be very confused if I learned that I get to set sysctl
options through the kernel command but need to use yet another format
than what I usually do to set those from the shell. Consistency is most
of the times to be preferred imho.

Also, the kernel docs illustrate that the "." syntax is used for other
keys as well (e.g. acpi.<option>) and userspace options passed via the
kernel command line have standardized on the "." format as well, e.g.
systemd appends in the same format (e.g.
systemd.unified_cgroup_hierarchy, systemd.unit what have you).

Christian
