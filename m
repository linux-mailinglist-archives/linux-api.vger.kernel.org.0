Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB812EA64B
	for <lists+linux-api@lfdr.de>; Tue,  5 Jan 2021 09:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbhAEIHg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Jan 2021 03:07:36 -0500
Received: from verein.lst.de ([213.95.11.211]:60453 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbhAEIHg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 5 Jan 2021 03:07:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9AF2867373; Tue,  5 Jan 2021 09:06:53 +0100 (CET)
Date:   Tue, 5 Jan 2021 09:06:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Kyle Anderson <kylea@netflix.com>,
        Manas Alekar <malekar@netflix.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Rob Gulewich <rgulewich@netflix.com>,
        Zoran Simic <zsimic@netflix.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] fs: Validate umount flags before looking up path in
 ksys_umount
Message-ID: <20210105080653.GA31398@lst.de>
References: <20210104215407.10161-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104215407.10161-1-sargun@sargun.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
