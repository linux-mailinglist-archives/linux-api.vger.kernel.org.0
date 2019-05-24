Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1AF328F88
	for <lists+linux-api@lfdr.de>; Fri, 24 May 2019 05:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbfEXDSZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 May 2019 23:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729972AbfEXDSZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 23 May 2019 23:18:25 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FAB621773;
        Fri, 24 May 2019 03:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558667905;
        bh=XwHg2mXb8WzJvbztibhVXfbFYRpVR6mtdv8vVyp0Duk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gOH1cU9zPFjRxln9OKY2r62pmt7/PemAORYbGNQaegIo+iNyQgDReb7QKaxHNrJMV
         wSO5kvL30yjVKbx/3MMAoDgQQRq/1VMw0+WCa8a6BuYmGleZmEV4g/sve7Ch1/cBre
         NLuOxJNpsd1jJge2pGr1UmmlztkDedgK2+m3hZgI=
Date:   Thu, 23 May 2019 20:18:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com, ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        aubrey.li@intel.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v18 1/3] proc: add /proc/<pid>/arch_status
Message-Id: <20190523201822.cc554d68ec567164bec781e1@linux-foundation.org>
In-Reply-To: <20190425143219.102258-1-aubrey.li@linux.intel.com>
References: <20190425143219.102258-1-aubrey.li@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 25 Apr 2019 22:32:17 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:

> The architecture specific information of the running processes
> could be useful to the userland. Add /proc/<pid>/arch_status
> interface support to examine process architecture specific
> information externally.

I'll give this an

Acked-by: Andrew Morton <akpm@linux-foundation.org>

from a procfs POV and shall let the x86 maintainers worry about it.

I must say I'm a bit surprised that we don't already provide some form
of per-process CPU-specific info anywhere in procfs.  Something to
piggy-back this onto.  But I can't find such a thing.

I assume we've already discussed why this is a new procfs file rather
than merely a new line in /proc/<pid>/status.  If so, please add the
reasoning to the changelog.  If not, please discuss now ;)


