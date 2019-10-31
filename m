Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C3CEA9CF
	for <lists+linux-api@lfdr.de>; Thu, 31 Oct 2019 05:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfJaEIi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 31 Oct 2019 00:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfJaEIi (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 31 Oct 2019 00:08:38 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A54C620859;
        Thu, 31 Oct 2019 04:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572494917;
        bh=S7ZWRS5+YaKNt1ZrSgoOeGZ5/gjvA8XfW9lupuyOdjQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aLY8g0Jui+5kmsZK4RQSjTJ9dR7W0t9sZShnderrSOwzvwVa0C8BIOBxtUdSfAi4J
         xQebDq0Gwg3kOG7PXV3YyZVNRen9jQdCx2F54K64YEJZog5Bcm6elmoAZBAF7T3THk
         mYicnjSxGysRcugJKpD5TQAG8H+eRi8GBiOeERrM=
Date:   Wed, 30 Oct 2019 21:08:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Li Xinhai" <lixinhai.lxh@gmail.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, Babka <vbabka@suse.cz>,
        Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        API <linux-api@vger.kernel.org>, Dickins <hughd@google.com>,
        linux-man@vger.kernel.org
Subject: Re: [PATCH v2] mm: Fix checking unmapped holes for mbind
Message-Id: <20191030210836.a17c0649354b59961903d1a8@linux-foundation.org>
In-Reply-To: <201910291756045288126@gmail.com>
References: <201910291756045288126@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

(cc linux-man@vger.kernel.org)

On Tue, 29 Oct 2019 17:56:06 +0800 "Li Xinhai" <lixinhai.lxh@gmail.com> wro=
te:

> queue_pages_range() will check for unmapped holes besides queue pages for
> migration. The rules for checking unmapped holes are:
> 1 Unmapped holes at any part of the specified range should be reported as
> =A0 EFAULT if mbind() for none MPOL_DEFAULT cases;
> 2 Unmapped holes at any part of the specified range should be ignored if
> =A0 mbind() for MPOL_DEFAULT case;
> Note that the second rule is the current implementation, but it seems
> conflicts the Linux API definition.

Can you quote the part of the API definition which you're looking at?

My mbind(2) manpage says

ERRORS
       EFAULT Part or all of the memory range specified by nodemask and max=
n-
              ode points outside your accessible address space.  Or, there =
was
              an unmapped hole in the specified memory range specified by a=
ddr
              and len.

(I assume the first sentence meant to say "specified by addr and len")

I agree with your interpretation, but there's no mention here that
MPOL_DEFAULT is treated differently and I don't see why it should be.


More broadly, I worry that it's too late to change this - existing
applications might fail if we change the implementation in the proposed
fashion.  So perhaps what we should do here is to change the manpage to
match reality?

Is the current behavior causing you any problems in a real-world use
case?
