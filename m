Return-Path: <linux-api+bounces-3270-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E03A3EC61
	for <lists+linux-api@lfdr.de>; Fri, 21 Feb 2025 06:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DB93B7570
	for <lists+linux-api@lfdr.de>; Fri, 21 Feb 2025 05:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432F71FBEA4;
	Fri, 21 Feb 2025 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hE5yNgaS"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2D1BD9DD;
	Fri, 21 Feb 2025 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117253; cv=none; b=VY4eGMyix+nEbeF+3LNsdUBAss88rjHoV9DENSlUEFS4wRWCsd2VkOgjCbimiZCvGTU4QEQga/wy23DxBxUT2qtvjwn64UpC7lsessVIAjjljt9LuxJRSXjr6BuvNDvHhttQva06bGLTKV9ocvEjXTNUrNLzcXXIoP/tj/ykgU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117253; c=relaxed/simple;
	bh=6nAqydpXz1vO6UPAfg46b8jqq0GbIq18lHPuuDeUhUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXacRVa4247qj7K6aeVDJjizjNYoYUflP0lHHh5KP9bCBXOgh9RIAHHt//NBKd2Fsk4UHYIUuTdE+nFfj9NnUo34KGOnWF+7hIq0hb5VORYMwAqCJTzO0ls9U5QhlQouLlNVYLoL8YSFH4+IFLy2IjMdG5Ua0LiFEhrRTF6c+XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hE5yNgaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2655DC4CEE2;
	Fri, 21 Feb 2025 05:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740117252;
	bh=6nAqydpXz1vO6UPAfg46b8jqq0GbIq18lHPuuDeUhUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hE5yNgaSs/VZcMKzEwgHXuWaWrT78BCRTHutmapWWdt5e8fQOUwlYi80PcOT/KEv/
	 yw70tD0q0pSeyXU4koE9z6LAAJYwofTVeyxfS6Yj7P0J/9YyLChSmQCcHci/ZXnjmL
	 U0b3zpXR9kYFvMHq/gH6zMXh+1L0I+32TT98woAM=
Date: Fri, 21 Feb 2025 06:53:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] ntsync: Check wait count based on byte size.
Message-ID: <2025022147-cargo-preface-7cdb@gregkh>
References: <20250220192334.549167-1-zfigura@codeweavers.com>
 <3342044.44csPzL39Z@camazotz>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3342044.44csPzL39Z@camazotz>

On Thu, Feb 20, 2025 at 01:29:25PM -0600, Elizabeth Figura wrote:
> On Thursday, 20 February 2025 13:23:34 CST Elizabeth Figura wrote:
> > GCC versions below 13 incorrectly detect the copy size as being static and too
> > small to fit in the "fds" array. Work around this by explicitly calculating the
> > size and returning EINVAL based on that, instead of based on the object count.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202502072019.LYoCR9bF-lkp@intel.com/
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> > 
> 
> Oops, I forgot to include a reference to v1:
> 
> https://lore.kernel.org/all/20250219001920.210847-1-zfigura@codeweavers.com/

No need for the reference, that's easy enough to find if I needed it.

thanks,

greg k-h

