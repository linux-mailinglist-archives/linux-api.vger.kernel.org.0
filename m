Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355AB1D0F9E
	for <lists+linux-api@lfdr.de>; Wed, 13 May 2020 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbgEMKXA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 May 2020 06:23:00 -0400
Received: from verein.lst.de ([213.95.11.211]:45588 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732472AbgEMKXA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 13 May 2020 06:23:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1852B68C65; Wed, 13 May 2020 12:22:57 +0200 (CEST)
Date:   Wed, 13 May 2020 12:22:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
Message-ID: <20200513102256.GA2087@lst.de>
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-11-maco@android.com> <CAB0TPYHwor85-fWKu+OMT-1ys2L7OSqVoReJRzNOMAE0xK+yzg@mail.gmail.com> <1f3064a9-105f-02bb-6a1a-eb9875d292e3@kernel.dk> <4416f60a-6050-5067-6881-0ee9ef944669@kernel.dk> <CAB0TPYHikHc3tTTQcUOOZsYZmqNxGtthpkPX_z6dKgy+V8kovg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYHikHc3tTTQcUOOZsYZmqNxGtthpkPX_z6dKgy+V8kovg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 13, 2020 at 09:07:43AM +0200, Martijn Coenen wrote:
> On Wed, May 13, 2020 at 4:30 AM Jens Axboe <axboe@kernel.dk> wrote:
> > > Looks acceptable to me, but I'm getting a failure applying it to
> > > for-5.8/drivers on this patch:
> > >
> > > Applying: loop: Refactor loop_set_status() size calculation
> > >
> > > So you'll probably want to respin on the right branch.
> 
> This series depends on a separate bugfix I sent to LKML earlier - see
> https://lkml.org/lkml/2020/3/31/755 . I mentioned it in [00/10] of
> this series, but perhaps I should have just included that patch.
> 
> I just verified that patch + this series still applies cleanly on your
> for-5.8/drivers tree, but if you prefer I send a v5 with that patch
> going first let me know.

You probably want to resend with the fix includes as the first patch.
And drop the truncation check now that we figured out that we don't
actually need it.
