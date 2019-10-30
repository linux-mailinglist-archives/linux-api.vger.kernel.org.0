Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 383F3E9B53
	for <lists+linux-api@lfdr.de>; Wed, 30 Oct 2019 13:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfJ3MJY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Oct 2019 08:09:24 -0400
Received: from gentwo.org ([3.19.106.255]:37994 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfJ3MJY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 30 Oct 2019 08:09:24 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 549D13EF15; Wed, 30 Oct 2019 12:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 523D63EECB;
        Wed, 30 Oct 2019 12:09:23 +0000 (UTC)
Date:   Wed, 30 Oct 2019 12:09:23 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Mike Rapoport <rppt@kernel.org>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
In-Reply-To: <20191030071136.GA20624@rapoport-lnx>
Message-ID: <alpine.DEB.2.21.1910301205001.14416@www.lameter.com>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org> <1572171452-7958-2-git-send-email-rppt@kernel.org> <20191028123124.ogkk5ogjlamvwc2s@box> <20191028130018.GA7192@rapoport-lnx> <20191028131623.zwuwguhm4v4s5imh@box> <alpine.DEB.2.21.1910290706360.3769@www.lameter.com>
 <20191029085551.GA18773@rapoport-lnx> <alpine.DEB.2.21.1910291011090.5411@www.lameter.com> <20191030071136.GA20624@rapoport-lnx>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On Wed, 30 Oct 2019, Mike Rapoport wrote:

> > /dev/securemem or so?
>
> A device driver will need to remove the secure area from the direct map and
> then we back to square one.

We have avoided the need for modifications to kernel core code. And its a
natural thing to treat this like special memory provided by a device
driver.


