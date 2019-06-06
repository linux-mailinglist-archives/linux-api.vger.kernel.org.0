Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C33E37FA4
	for <lists+linux-api@lfdr.de>; Thu,  6 Jun 2019 23:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfFFVeC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 6 Jun 2019 17:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfFFVeC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 6 Jun 2019 17:34:02 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 425B8206BB;
        Thu,  6 Jun 2019 21:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559856841;
        bh=IBMakSAmxp2Ih7MrARdyOGb6a4i5uA7woITej/AKKnI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ISqfp6hTYjffzsObhMCnRqPeZw2vZjXkA6IDcdwg+OzVRM3YolpZrfl4RaCgwI5BA
         T0o1vRvAlJ0vf/QdrH7xmFdH+C5RuJ33pRryt9dNFpuGdMwVZ8KVK0xtL8GXLTGPOM
         xRpZViqMDQt4lM4GTjfgdwHyXDcVIUzDR74jyWPs=
Date:   Thu, 6 Jun 2019 14:34:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com, ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        aubrey.li@intel.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v19 1/3] proc: add /proc/<pid>/arch_status
Message-Id: <20190606143400.9f4a584eb1dc640fdf334114@linux-foundation.org>
In-Reply-To: <20190606012236.9391-1-aubrey.li@linux.intel.com>
References: <20190606012236.9391-1-aubrey.li@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu,  6 Jun 2019 09:22:34 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:

> The architecture specific information of the running processes
> could be useful to the userland. Add /proc/<pid>/arch_status
> interface support to examine process architecture specific
> information externally.

I'll grab these for some testing.  I can merge them up if the x86
maintainers are OK with it all.  However I think it's best that these
be merged via an x86 tree, please.

