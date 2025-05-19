Return-Path: <linux-api+bounces-3811-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BA9ABC01C
	for <lists+linux-api@lfdr.de>; Mon, 19 May 2025 16:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282E5172BC9
	for <lists+linux-api@lfdr.de>; Mon, 19 May 2025 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27BC2820BE;
	Mon, 19 May 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P636DutZ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1D1277006
	for <linux-api@vger.kernel.org>; Mon, 19 May 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663379; cv=none; b=YbDVpyUOtbaZolV/h81O4Z4LIBiX434RJrBrnEGVYrjEAeZUcnjjmUa8d+u2hSIP4OPSorRqETdolA09rilKb1NSd8M3EKvYwpQ4Y8tWxMzplVBZmM+QuoMI0VyCXuVp7eMv7sCm0LRHysBkw+TPoCkg7kP52F2IF+tKqNdUCyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663379; c=relaxed/simple;
	bh=6JeicjUHmHodkNN/zM/djUCuOR2HOijRfC1PdA6i1Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfplfCUDrqejb4rstBmeXWpEJ/XaLDvfkX3Qlq/IvLyeidXs+lsGjvaM62pOTr04N7qyY8eqnin4JZGGqKzaypuc5gst0bu8U7rqQf4cL8yn2/qsKVbYNpcOCG48B0kh3CmYuciN7R6QC3NwYjYLQtq6ZgTCx0QEqzHXI6HrVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P636DutZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a3681aedf8so1722109f8f.1
        for <linux-api@vger.kernel.org>; Mon, 19 May 2025 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747663375; x=1748268175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWHK376VyM/OI/YTUsa3tJsiwaElzvKB3NW3NOhpiiM=;
        b=P636DutZeVZfwjnLwuxbXt9gvNyYJSKX2bNgrVDsov0uHT4nKxEBaOfkCx+Upz0I7T
         VLN42EeAIvGmwPhJkQsQ0l0iJN/KBsDN3/qk1xsPE3oTKcxYm7HshGQpOcR6xGnoJWYs
         qXsOvMNFlV6lXskj8xwEqoaEK56QpQOlXqIf0I13Nf/Vt2VQCPUnOWFXipvCATD7dt0O
         rRCMm6/sQopHxPZbDy2Nsf0cXgB05xh3dcs4n47rn2PuQkds16tjOCIFtlCofp4E1QJO
         pUdEivieJJ5zG9fNXD3OYNAiJUEN/aNfVfW4KfMJK45zsfCjGlrgo5lFMbrxD3TWyuG9
         R7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747663375; x=1748268175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWHK376VyM/OI/YTUsa3tJsiwaElzvKB3NW3NOhpiiM=;
        b=EfgqnBW+zkjFlwJYnh747Z5uTVUOiMZyqYB/iqD88w5KTAJjmGcHKU/xjjQwEG/Jcr
         ekABtetdBRA6d/QKdaW7sT+rAci5te5aLhQlE+TX+FXgWFsrmHnIW8yeCgSdt+P3LSGy
         ftJYEcASkCjUlELjVrIJlb8uARUg/UI3UM6YsuBYbXVT0eiQEDQIjk0niHd9xTTpfxZS
         E4P84WyDINMVIiXtBoyXSJyq0dFH7jE1EqrRP0zphdra7Wi5c01hUdogSIQaVeS0uQlV
         0FWGBd78EXM49eE7BjkZ9S+GgH4/wtC4RjBQO2Eh5rgNDNkByLZ1bb3Vg8o3okwS0xoF
         xDgA==
X-Forwarded-Encrypted: i=1; AJvYcCUr23duikgVvdLa8bI4PAzo8sn3JRunDpa0EaRxaryZP+Q6iQ6I3wQmg+ld1hVnbKtpTWW5wXCT5yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG4avo5BLO7QioWW62y8VWzC8iCXJ5abG4QXQbfEnOxv0BOF6V
	swDfIHz8VtAoOdsJsZx/TPTxtrjWiOQDQLQpXjd3LB2E03ocrK2tNfwEWvC12Wrphmk=
X-Gm-Gg: ASbGncuolu5qdNavM7EsOTWxBBokcQSaZ/o5w7UkCja4NmVIbAx5j/38ImY604dJHMY
	HiRtgXl86y9d0RSzxz7D679VCHQiIgdxKS7i4oqkR+38nDb86NWp7zqYFu4Ozy+1zJc/msYkyZ/
	ZhcK7wbQ4vRq8GczsYhi9iQyrWUQ4ooD2H3ASqbPDqmiECZcfwUroM7D1lmC3LDHiPC+x4LfWYT
	jJFi4D76BOf3SrsHpfQByrYPJ05em177HPiO5ZilH/V00VIbfvryxzxCTPmWEEB9XqBceLql1ag
	pSKdnRBqt2onnWc=
X-Google-Smtp-Source: AGHT+IHgFSt1Ji7/vd8gjbKHf9/ZDkJicJQQ8h96um9tpOt5m+Et9jN1XlhPEUTYTozb2xYGapLzmg==
X-Received: by 2002:a05:6000:2482:b0:3a3:652d:1631 with SMTP id ffacd0b85a97d-3a3652d1856mr7082207f8f.16.1747663375211;
        Mon, 19 May 2025 07:02:55 -0700 (PDT)
Received: from localhost ([213.208.157.38])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a35ca4d230sm12787370f8f.4.2025.05.19.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:02:54 -0700 (PDT)
Date: Mon, 19 May 2025 16:02:51 +0200
From: Michal Hocko <mhocko@suse.com>
To: Bharat Agrawal <bharat.agrawal@ansys.com>
Cc: "hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"rientjes@google.com" <rientjes@google.com>,
	"zhangyiru3@huawei.com" <zhangyiru3@huawei.com>,
	"mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
	"liuzixian4@huawei.com" <liuzixian4@huawei.com>,
	"wuxu.wu@huawei.com" <wuxu.wu@huawei.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: mlock ulimits for SHM_HUGETLB
Message-ID: <aCs6C2vKbecx-boy@tiehlicka>
References: <SJ2PR01MB8345DF192742AC4DB3D2CBB78E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR01MB8345DF192742AC4DB3D2CBB78E9CA@SJ2PR01MB8345.prod.exchangelabs.com>

Hi,
On Mon 19-05-25 10:21:17, Bharat Agrawal wrote:
> Hi all,
> 
> Could anyone please help comment on the risks associated with an
> application throwing the "Using mlock ulimits for SHM_HUGETLB is
> deprecated" message on RHEL 8.9 with 4.18.0-513.18.1.el8_9.x86_64
> Linux kernel?

This is not RHEL specific behavior. The current Linus tree has the same
warning which has been added by 
: commit 2584e517320bd48dc8d20e38a2621a2dbe58fade
: Author: Ravikiran G Thirumalai <kiran@scalex86.org>
: Date:   Tue Mar 31 15:21:26 2009 -0700
: 
:     mm: reintroduce and deprecate rlimit based access for SHM_HUGETLB
: 
:     Allow non root users with sufficient mlock rlimits to be able to allocate
:     hugetlb backed shm for now.  Deprecate this though.  This is being
:     deprecated because the mlock based rlimit checks for SHM_HUGETLB is not
:     consistent with mmap based huge page allocations.
: 
:     Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
:     Reviewed-by: Mel Gorman <mel@csn.ul.ie>
:     Cc: William Lee Irwin III <wli@holomorphy.com>
:     Cc: Adam Litke <agl@us.ibm.com>
:     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
:     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

HTH
-- 
Michal Hocko
SUSE Labs

