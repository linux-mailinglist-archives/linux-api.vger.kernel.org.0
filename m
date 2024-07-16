Return-Path: <linux-api+bounces-1973-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA359325BA
	for <lists+linux-api@lfdr.de>; Tue, 16 Jul 2024 13:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE65D1C21CC0
	for <lists+linux-api@lfdr.de>; Tue, 16 Jul 2024 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019341991C5;
	Tue, 16 Jul 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyqlKVxe"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EFE55897
	for <linux-api@vger.kernel.org>; Tue, 16 Jul 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129761; cv=none; b=GdY9MPd2tlKpq99czKXvJnsaqnAEBrA95SuFx+tQBstuTqHkWmUEYcRhZ/doZsZiJLFdV2HAy38QQDt8FOqjjhSOqRkWA4g/7tCyzWBlML6Atx6NWokVRW3GLEWn2ZGDo82bCPx5an032SQn5f2J4xL69zlCBrlgdw/KeKFbqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129761; c=relaxed/simple;
	bh=9u1aTHcNBkRJvWOW94arN5xGDqvGf2duJg3jg1Sch1c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fN2UfdYXb1Eh2lOGLlaifup2JAbIlBmc8YishHtnZOpWxuhme7cuSPdOijSYbhYXeupJdP6jzMzAqD0IU2Vf0ErmxPTNabtIGSqv53OfRHX4Oz2uyed0K1usJAz8EgyCKu3MVU+QL/Z6Qwos/eirelMuMHuPTuYQG1vCTtGiEzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyqlKVxe; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70211abf4cbso3642691a34.3
        for <linux-api@vger.kernel.org>; Tue, 16 Jul 2024 04:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721129759; x=1721734559; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T82xgTiZeLnfrmbWJsDkjudRwKXsnzcZ/xgyYUSgJoQ=;
        b=lyqlKVxeH2LrDGHUeHUHQRA+cX0DTmIJk7sIiVzf6p20uLK6Y0f1rLCrWVnsOPXiPv
         +LpHmdcBRm2BKMGLPzpWKbh2v5U8mAhYL4V+fAuTJ2HGO5rCK1oAGuc4fzfl9dqUDAXZ
         vdq5AkxxPatyddmL8HaC17aXcDxR5sMIw7QKDEogaIGc1BWN2/K4siUsQVsX39a/H3VF
         H0J8vw+RQNPnd+BSY3a0xOoABzcamlew/M/8+HoN7RxQmg76Q+dLzThl4iXUzY3HizA3
         Y8MVwJGaHXW9vftx/5vN38xLsyZEb9HzLptce34A9gR21Bf2s76sWBMnR0KSD8L1/rG3
         1Lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129759; x=1721734559;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T82xgTiZeLnfrmbWJsDkjudRwKXsnzcZ/xgyYUSgJoQ=;
        b=s85wr44/JS6OC8jar9Oc1myTIuFuGjz6nVH5PrOyD0v3u8yI0GlDWSiQeHBO03epxf
         tVb/YPrZWKR5WZ/RPBKY1KqJQSZfds1GNo44Z6K3ttRgl9taTHDc9AztBsGJgLeR1ox2
         aWzb0MT0SVJUtoKki6k95x/8L6vSegiqXArZ9dNDNKxJoLSMRlP4tIYb5pg3x59KIQyB
         +2RtQfgSyZwlpyEFZzb5v0OI+ZRlVfDSgpr9pfevuBY15XWeCP7S6Qa/V8wR3NeiPGMG
         SqLUdpIB9kKEVXFlgISQSKHuwF1vO08nAYhBZMHNoA+vl+Q7sgdU42zutwlLE9Rl99XD
         yoLQ==
X-Gm-Message-State: AOJu0YxdxTI0JQHfBTMvXFuivA4CRZ8/8sUjb1FytVtZaN0GpIe2r34G
	Y/nGDjCbI3NIZ7qLo26yF8ly8Za3KdYpApC27XgumTIRjwBoB7UwBDRJHlHlmJptvX4q6ReDGWj
	nUATDn+aWANAcNmdTVZvGFp1DX6IYLdiJ2Y0=
X-Google-Smtp-Source: AGHT+IGDxBGp/UBRisgtJZ/G3oWZZbdJ9RAPJbK2g8PS19jEatvmSuQwK91EmR1poDKhK7Y+VKiA5hbW8kJlv6I8V2w=
X-Received: by 2002:a05:6870:c1d2:b0:25e:1f67:b3c2 with SMTP id
 586e51a60fabf-260bdd5b993mr1629761fac.1.1721129759208; Tue, 16 Jul 2024
 04:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mathias Dufresne <mathias.dufresne@gmail.com>
Date: Tue, 16 Jul 2024 13:35:45 +0200
Message-ID: <CABwLUpt7jT594p-un1yxBN8ewvY+OfJhMdUSRmAuJAYDW2jNMQ@mail.gmail.com>
Subject: [question] about NFS4 ACLs
To: linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

I'm posting here as I don't really know where to start...  I'm a
sysadmin with almost no knowledge regarding what I'll speak about.

For some Samba related reasons, I dived into NFS4 ACLs support on
Linux and from what I understood, Linux is almost the last system to
refuse to support this kind of ACLs.

From what I understood (I insist as I'm not sure my understanding is
good enough) an API could be built to reside on Kernel side then
software developers would be able to write something to use that API.
These API accesses are, in my mind, doable by FS modules as by FS
clients, both in user land and so regardless of the licence used by
these codes.

As I found quite a bit of literature on that subject, I believe that
adding such an API, if possible, would please a decent bunch of
people.

So, first question: am I completely wrong about the feasibility and/or
the way things could work?
Then, is there a reason to not add this feature to our beloved Kernel
tree? Except time to work on it...

My apologies for the noise and best regards,

Mathias Dufresne

