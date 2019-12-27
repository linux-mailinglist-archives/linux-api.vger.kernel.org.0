Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9883C12B048
	for <lists+linux-api@lfdr.de>; Fri, 27 Dec 2019 02:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfL0Bf2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Dec 2019 20:35:28 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40652 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfL0Bf2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Dec 2019 20:35:28 -0500
Received: by mail-ed1-f67.google.com with SMTP id b8so24091614edx.7
        for <linux-api@vger.kernel.org>; Thu, 26 Dec 2019 17:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2hkxx6EdZesk3LyhW8Bjdi5OF7N5XgZx/OPo6iWL4k=;
        b=awumovmJVECZ0Nk/zD/7/Ex5YMktKw7NhFajPm4bgFTiF2ETfkapjS8VlX3uLqpIRv
         6JofoXtruG/OJh5ZP2aFM8aE1WMGWcpoQpgjKTLp/hJjiPjkBlvWQnp7nh8qDj+Uuo+X
         qMEtfHNJZv98S6kmQcWJMShyoywEiEEU28hTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2hkxx6EdZesk3LyhW8Bjdi5OF7N5XgZx/OPo6iWL4k=;
        b=eARk0xKtdv/5I6CHUX0ci/653cU7JUkLnJD9QFMs3YGmfCwiMuVRjTGpMDYE/qKJc9
         1h+jgFuqPnP/5BL221dwNWgPymzeuHCLDqAx3fSB6cszKs7367aYeF/fSkwNMH87Mref
         9spExmxAEevNo0E45rs7jTSWd9qY3Rmex3fIYcsWdvBhFJ+siRyy/RLfN8BYXvaK6Pku
         n8ydYVDz+U7m1jkZfIlvBCxymZg2sopvcGvcQ0qvWHoeUZQdiNDS+rb/eMtWe+YQ8Bsm
         RpZp3W0dS7yOTnSoRb8fS/Ol+nvreMKuxdgfgADeV3f6iac9V574uNWe6tmrKqY76Vz2
         acjQ==
X-Gm-Message-State: APjAAAU2KQxvHGIDWl05eeSBFyTwNXohiHVSJAGAaPe/SdL8LkUPOuAp
        Z6mI21iPv0INjxMmC4OqHHRm50HfoEBarctnrkP9Ow==
X-Google-Smtp-Source: APXvYqziVcuWKxoTC5z2LyoMJWVCIQfGh0OJGrspzG1O5SgJ6+Lq/NGsxHbojw3SUweZkNqEh948ArUOFWHF6ZSqFe8=
X-Received: by 2002:aa7:d714:: with SMTP id t20mr53554307edq.93.1577410526273;
 Thu, 26 Dec 2019 17:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20191226180334.GA29409@ircssh-2.c.rugged-nimbus-611.internal> <201912270545.TQnRs9kG%lkp@intel.com>
In-Reply-To: <201912270545.TQnRs9kG%lkp@intel.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 26 Dec 2019 20:35:00 -0500
Message-ID: <CAMp4zn94deUbkXBrnX=Omw9-FmoZDANApqYUVsaV+VsXCX4Q-w@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] pid: Introduce pidfd_getfd syscall
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jed Davis <jld@mozilla.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Dec 26, 2019 at 5:20 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Sargun,
>
> Thank you for the patch! Yet something to improve:
>
> All errors (new ones prefixed by >>):
>
>    arch/alpha/kernel/systbls.o: In function `sys_call_table':
> >> (.data+0x1120): undefined reference to `sys_pidfd'
This is a small typo. I'll fix this in the next respin.


>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
